import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/notifiers/theme_notifier.dart';
import 'package:covid_19_tracker/pages/countryWiseStats.dart';
import 'package:covid_19_tracker/pages/indiaStats.dart';
import 'package:covid_19_tracker/utils/constants/constants.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/utils/theme/app_theme.dart';
import 'package:covid_19_tracker/utils/theme/dark_theme_preference.dart';
import 'package:covid_19_tracker/widgets/customHeadingWidget.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/custom_button.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/mostAffectedCountriesWidget.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:covid_19_tracker/widgets/platform_alert_dialog.dart';
import 'package:covid_19_tracker/widgets/worldWideWidget.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WorldData worldCachedData;
  List countriesCachedData;
  Box worldDataBox;
  Box countryDataBox;
  CommonBloc bloc;
  ThemeNotifier themeNotifier;
  bool _darkModeEnabled;

  void initState() {
    super.initState();
    bloc = Provider.of<CommonBloc>(context, listen: false);
    themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _darkModeEnabled = (themeNotifier.getTheme() == AppTheme.darkTheme());
    getCachedData();
    updateData();
  }

  @override
  void dispose() {
    bloc.disposeWorldandCountryDataStreams();
    super.dispose();
  }

  void getCachedData() {
    try {
      worldDataBox = Hive.box(HiveBoxes.worldData);
      countryDataBox = Hive.box(HiveBoxes.countriesData);
      worldCachedData =
          worldDataBox.isNotEmpty ? worldDataBox.values.last : null;
      countriesCachedData =
          countryDataBox.isNotEmpty ? countryDataBox.values.last : null;
    } catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Error in Reading Data',
        contentText:
            'Can\'t read data from storage, Contact support or try again later',
        defaultActionButtonText: 'Ok',
      );
    }
  }

  Future<void> updateData() async {
    try {
      await bloc.getCombinedData();
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: 'No Internet',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } on Response catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Error',
        contentText: 'Please try again later',
        defaultActionButtonText: 'Ok',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Unknown Error',
        contentText: 'Please try again later.',
        defaultActionButtonText: 'Ok',
      );
    }
  }

  Widget _buildPieChartPannel(bool isLoading) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      color: Colors.amber[300],
      elevation: 4.0,
      child: PieChartWidget(
        total: double.tryParse(
          isLoading ? worldCachedData.cases : bloc.worldData.cases,
        ),
        active: double.tryParse(
          isLoading ? worldCachedData.active : bloc.worldData.active,
        ),
        recovered: double.tryParse(
          isLoading ? worldCachedData.recovered : bloc.worldData.recovered,
        ),
        deaths: double.tryParse(
          isLoading ? worldCachedData.deaths : bloc.worldData.deaths,
        ),
        totalColor: Colors.red[400],
        activeColor: Colors.blue,
        recoveredColor: Colors.green[400],
        deathsColor: Colors.grey[400],
      ),
    );
  }

  Future<void> onThemeChange() async {
    _darkModeEnabled = !_darkModeEnabled;
    themeNotifier.setTheme(
      _darkModeEnabled ? AppTheme.darkTheme() : AppTheme.lightTheme(),
    );
    await DarkThemePreference().setDarkTheme(_darkModeEnabled);
  }

  Widget _buildStreamContents(bool isLoading) {
    if (isLoading &&
        ((worldDataBox?.isEmpty ?? true) ||
            (countryDataBox?.isEmpty ?? true))) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: CustomProgressIndicator(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WorldWideWidget(
          worldData: isLoading ? worldCachedData : bloc.worldData,
        ),
        const CustomHeadingWidget(title: 'Most Affected Countries'),
        MostAffectedWidget(
          countryData: isLoading ? countriesCachedData : bloc.countriesData,
        ),
        const CustomHeadingWidget(title: 'Statistics...'),
        _buildPieChartPannel(
          isLoading,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('COVID-19 TRACKER'),
        elevation: 2.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.04,
            ),
            child: DayNightSwitcherIcon(
              isDarkModeEnabled: _darkModeEnabled,
              onStateChanged: (_) => onThemeChange(),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () => updateData(),
        height: 60.0,
        animSpeedFactor: 5.0,
        color: Theme.of(context).accentColor,
        child: Builder(
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () => bloc.onWillPop(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      height: size.height * 0.1,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 2.0,
                      ),
                      color: Colors.orange[100],
                      child: AutoSizeText(
                        StaticData.quote,
                        maxLines: 3,
                        minFontSize: 12.0,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: AutoSizeText(
                                'Worldwide',
                                maxLines: 1,
                                minFontSize: 18.0,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CustomRaisedButton(
                                    title: 'Regional',
                                    onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) {
                                          return CountryWiseStats();
                                        },
                                      ),
                                    ),
                                  ),
                                  CustomRaisedButton(
                                    title: 'India\'s Stats',
                                    onPressed: () => Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) {
                                          return IndiaStats();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: bloc.dataLoadingStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return _buildStreamContents(snapshot.data);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InfoWidget(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'WE STAND TOGETHER TO FIGHT WITH THIS',
                          maxLines: 1,
                          minFontSize: 12,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
