import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/pages/countryWiseStats.dart';
import 'package:covid_19_tracker/pages/indiaStats.dart';
import 'package:covid_19_tracker/providers/theme_provider.dart';
import 'package:covid_19_tracker/providers/world_data_provider.dart';
import 'package:covid_19_tracker/utils/constants/constants.dart';
import 'package:covid_19_tracker/utils/enums/data_state.dart';
import 'package:covid_19_tracker/utils/theme/app_theme.dart';
import 'package:covid_19_tracker/utils/theme/dark_theme_preference.dart';
import 'package:covid_19_tracker/widgets/customHeadingWidget.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/custom_button.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/mostAffectedCountriesWidget.dart';
import 'package:covid_19_tracker/widgets/noData.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:covid_19_tracker/widgets/worldWideWidget.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<WorldDataProvider>(
      create: (_) => WorldDataProvider(),
      child: HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const snackBarDuration = Duration(seconds: 3);

  late final ThemeProvider themeNotifier;
  late final WorldDataProvider worldDataProvider;
  late bool _darkModeEnabled;

  DateTime? backButtonPressedTime;

  @override
  void initState() {
    super.initState();
    worldDataProvider = Provider.of<WorldDataProvider>(context, listen: false);
    worldDataProvider.getCachedData();
    worldDataProvider.updateData();
    themeNotifier = Provider.of<ThemeProvider>(context, listen: false);
    _darkModeEnabled = themeNotifier.getTheme() == AppTheme.darkTheme();
  }

  Future<void> onThemeChange() async {
    _darkModeEnabled = !_darkModeEnabled;
    themeNotifier.setTheme(
      _darkModeEnabled ? AppTheme.darkTheme() : AppTheme.lightTheme(),
    );
    await DarkThemePreference().setDarkTheme(_darkModeEnabled);
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentTime = DateTime.now();

    final backButtonNotPressedTwice = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) > snackBarDuration;

    if (backButtonNotPressedTwice) {
      backButtonPressedTime = currentTime;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: snackBarDuration,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const AutoSizeText(
          'COVID-19 TRACKER',
          maxLines: 1,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
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
        onRefresh: () => worldDataProvider.updateData(),
        height: 60.0,
        animSpeedFactor: 5.0,
        color: Theme.of(context).accentColor,
        child: Builder(
          builder: (_) {
            return WillPopScope(
              onWillPop: () => onWillPop(context),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Expanded(
                          flex: 9,
                          child: CustomHeadingWidget(title: "Worldwide"),
                        ),
                        Expanded(
                          flex: 16,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CustomRaisedButton(
                                  title: 'Regional',
                                  onPressed: () {
                                    if (worldDataProvider.countriesData !=
                                        null) {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (_) {
                                            return CountryWiseStats(
                                              countriesData: worldDataProvider
                                                  .countriesData!,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                CustomRaisedButton(
                                  title: "India's Stats",
                                  onPressed: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (_) {
                                        return IndiaStats.create();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<WorldDataProvider>(
                      builder: (_, worldDataProvider, __) {
                        switch (worldDataProvider.dataState) {
                          case DataLoadState.idle:
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: CustomProgressIndicator(),
                            );
                          case DataLoadState.loadingFromServer:
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: CustomProgressIndicator(),
                            );
                          case DataLoadState.updatingFromServer:
                            return _buildContents();
                          case DataLoadState.noInternet:
                            if (worldDataProvider.worldData == null ||
                                worldDataProvider.countriesData == null) {
                              return const NoData(
                                title:
                                    "Can't load data at the moment. Please try again later",
                              );
                            }
                            return _buildContents();
                          case DataLoadState.overallFailure:
                            return const NoData(title: "Can't load data");
                          case DataLoadState.success:
                            return _buildContents();
                          case DataLoadState.serverError:
                            return const NoData(
                              title: "Server Error. Please try again later",
                            );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const InfoWidget(),
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
                          overflow: TextOverflow.ellipsis,
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

  Widget _buildContents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WorldWideWidget(
          worldData: worldDataProvider.worldData!,
        ),
        const CustomHeadingWidget(title: 'Most Affected Countries'),
        MostAffectedWidget(
          countriesData: worldDataProvider.countriesData!,
        ),
        const CustomHeadingWidget(title: 'Statistics...'),
        Card(
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
            total: double.tryParse(worldDataProvider.worldData!.cases)!,
            active: double.tryParse(worldDataProvider.worldData!.active)!,
            recovered: double.tryParse(worldDataProvider.worldData!.recovered)!,
            deaths: double.tryParse(worldDataProvider.worldData!.deaths)!,
            totalColor: Colors.red[400]!,
            activeColor: Colors.blue,
            recoveredColor: Colors.green[400]!,
            deathsColor: Colors.grey[400]!,
          ),
        )
      ],
    );
  }
}
