import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/data/data.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/models/worldData.dart';
import 'package:covid_19_tracker/pages/countryWiseStats.dart';
import 'package:covid_19_tracker/pages/indiaStats.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/mostAffectedCountriesWidget.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:covid_19_tracker/widgets/worldWideWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<CommonBloc>(
      create: (_) => CommonBloc(),
      child: HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WorldData worldCachedData;
  List countriesCachedData;
  IndiaData indiaCachedData;
  Box<WorldData> worldDataBox;
  Box countryDataBox;
  Box<IndiaData> indiaDataBox;

  Future<void> loadDataOnRefresh(CommonBloc bloc) async {
    await bloc.getCombinedData();
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 100.0,
      child: SpinKitFadingCircle(
        color: primaryBlack,
      ),
    );
  }

  void initState() {
    super.initState();
    getCachedData();
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    bloc.getCombinedData();
  }

  void getCachedData() {
    worldDataBox = Hive.box<WorldData>(HiveBoxes.worldData);
    worldCachedData = worldDataBox.isEmpty ? null : worldDataBox.values.last;
    print('Most Recent WorldData: ${worldCachedData.toString()}');

    countryDataBox = Hive.box(HiveBoxes.countriesData);
    countriesCachedData =
        countryDataBox.isEmpty ? null : countryDataBox.values.last;
    print('Most Recent CountriesData: ${countriesCachedData.toString()}');
  }

  Widget _buildWorldWidePannel(
    CommonBloc bloc,
    bool isLoading,
  ) {
    if (isLoading && worldDataBox.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: _buildProgressIndicator(),
      );
    }
    return WorldWideWidget(
      worldData: isLoading ? worldCachedData : bloc.worldData,
    );
  }

  Widget _buildMostAffectedCountriesPannel(
    bool isLoading,
    CommonBloc bloc,
  ) {
    if (isLoading && countryDataBox.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: _buildProgressIndicator(),
      );
    }
    return MostAffectedWidget(
      countryData: isLoading ? countriesCachedData : bloc.countriesData,
    );
  }

  Widget _buildPieChartPannel(bool isLoading, CommonBloc bloc) {
    if (isLoading && worldDataBox.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: _buildProgressIndicator(),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    AppBar appbar = AppBar(
      title: const Text('COVID-19 TRACKER'),
    );
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar,
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () => loadDataOnRefresh(bloc),
        height: 60.0,
        animSpeedFactor: 5.0,
        color: primaryBlack,
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
                      height: (height -
                              (appbar.preferredSize.height +
                                  MediaQuery.of(context).padding.top)) *
                          0.12,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      color: Colors.orange[100],
                      child: Text(
                        StaticData.quote,
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Worldwide',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CountryWiseStats.create(
                                            context,
                                          );
                                        },
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: primaryBlack,
                                      ),
                                      child: const Text(
                                        'Regional',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return IndiaStats.create(context);
                                        },
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: primaryBlack,
                                      ),
                                      child: const Text(
                                        'India\'s Stats ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: bloc.dataLoadingStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return _buildWorldWidePannel(
                          bloc,
                          snapshot.data,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        'Most Affected Countries',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: bloc.dataLoadingStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return _buildMostAffectedCountriesPannel(
                          snapshot.data,
                          bloc,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: const Text(
                        'Statistics...',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: bloc.dataLoadingStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return _buildPieChartPannel(
                          snapshot.data,
                          bloc,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InfoWidget(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: const Text(
                        'WE STAND TOGETHER TO FIGHT WITH THIS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
