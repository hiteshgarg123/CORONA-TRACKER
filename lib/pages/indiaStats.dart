import 'dart:io';

import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/data/data.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/pages/indiaStatewise.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/gridBox.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:covid_19_tracker/widgets/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class IndiaStats extends StatefulWidget {
  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  Box<IndiaData> indiaDataBox;
  IndiaData indiaCachedData;
  IndiaData indiaData;
  CommonBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<CommonBloc>(context, listen: false);
    getCachedData();
    updateData();
  }

  @override
  void dispose() {
    bloc.disposeIndiaDataStream();
    super.dispose();
  }

  void getCachedData() {
    try {
      indiaDataBox = Hive.box<IndiaData>(HiveBoxes.indiaData);
      indiaCachedData =
          indiaDataBox.isNotEmpty ? indiaDataBox.values.last : null;
    } catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Error Reading Data',
        contentText:
            'Can\'t read data from storage, Contact support or try again later',
        defaultActionButtonText: 'Ok',
      );
    }
  }

  Future<void> updateData() async {
    try {
      await bloc.getIndiaData();
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        titleText: 'Connection error',
        contentText: 'Could not retrieve latest data, Please try again later.',
        defaultActionButtonText: 'Ok',
      );
    } on Response catch (response) {
      showAlertDialog(
        context: context,
        titleText: response.statusCode.toString(),
        contentText: 'Error Retrieving Data',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('India\'s Stats'),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () => updateData(),
        showChildOpacityTransition: false,
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

  Widget _buildContent(CommonBloc bloc, bool isLoading) {
    if (isLoading && indiaDataBox.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: CustomProgressIndicator(),
      );
    }
    indiaData = isLoading ? indiaCachedData : bloc.indiaData;
    return Container(
      height: MediaQuery.of(context).size.height,
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
                            indiaData: indiaData,
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
                  count: indiaData.confirmed,
                  boxColor: Colors.red[300].withOpacity(0.80),
                  textColor: Colors.red[900],
                ),
                GridBox(
                  title: 'ACTIVE',
                  count: indiaData.active,
                  boxColor: Colors.blue[300],
                  textColor: Colors.blue[900],
                ),
                GridBox(
                  title: 'DEATHS',
                  count: indiaData.deaths,
                  boxColor: Colors.grey,
                  textColor: Colors.grey[900],
                ),
                GridBox(
                  title: 'RECOVERED',
                  count: indiaData.recovered,
                  boxColor: Colors.green[400],
                  textColor: Colors.green[900],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                total: double.tryParse(indiaData.confirmed),
                active: double.tryParse(indiaData.active),
                recovered: double.tryParse(indiaData.recovered),
                deaths: double.tryParse(indiaData.deaths),
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
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: const Text(
                'WE STAND TOGETHER TO FIGHT WITH THIS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
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
