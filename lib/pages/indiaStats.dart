import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../blocs/homepage_bloc.dart';
import '../data/datasource.dart';
import '../pages/indiaStatewise.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/infoWidget.dart';
import '../widgets/pieChart.dart';
import '../widgets/gridBox.dart';

class IndiaStats extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: IndiaStats(),
    );
  }

  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<HomePageBloc>(context, listen: false);
    bloc.getIndiaData();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomePageBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('India\'s Stats'),
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: bloc.loadIndiaDataOnRefresh,
        height: 60.0,
        animSpeedFactor: 5.0,
        color: primaryBlack,
        child: StreamBuilder<bool>(
          stream: bloc.indiaDataLoadingStream,
          initialData: true,
          builder: (context, snapshot) {
            return _buildContent(
              bloc,
              snapshot.data,
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(HomePageBloc bloc, bool isLoading) {
    return isLoading == true
        ? CustomProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Overall Stats...',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return IndiaStatewise(
                                  indiaData: bloc.indiaData,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: primaryBlack,
                          ),
                          child: const Text(
                            'Statewise',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                    ),
                    children: <Widget>[
                      GridBox(
                        title: 'TOTAL CASES',
                        count: bloc.indiaData['data']['total']['confirmed']
                            .toString(),
                        boxColor: Colors.red[300].withOpacity(0.80),
                        textColor: Colors.red[900],
                      ),
                      GridBox(
                        title: 'ACTIVE',
                        count: bloc.indiaData['data']['total']['active']
                            .toString(),
                        boxColor: Colors.blue[300],
                        textColor: Colors.blue[900],
                      ),
                      GridBox(
                        title: 'DEATHS',
                        count: bloc.indiaData['data']['total']['deaths']
                            .toString(),
                        boxColor: Colors.grey,
                        textColor: Colors.grey[900],
                      ),
                      GridBox(
                        title: 'RECOVERED',
                        count: bloc.indiaData['data']['total']['recovered']
                            .toString(),
                        boxColor: Colors.green[400],
                        textColor: Colors.green[900],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: const Text(
                    'Visuals',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  color: Colors.orange[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4.0,
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                    child: PieChartWidget(
                      total: bloc.indiaData['data']['total']['confirmed']
                          .toDouble(),
                      active:
                          bloc.indiaData['data']['total']['active'].toDouble(),
                      recovered: bloc.indiaData['data']['total']['recovered']
                          .toDouble(),
                      deaths:
                          bloc.indiaData['data']['total']['deaths'].toDouble(),
                      totalColor: Colors.red[400],
                      activeColor: Colors.blue[400],
                      recoveredColor: Colors.green[300],
                      deathsColor: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
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
          );
  }
}
