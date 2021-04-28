import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/pages/indiaStatewise.dart';
import 'package:covid_19_tracker/utils/constants/hive_boxes.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:covid_19_tracker/widgets/customHeadingWidget.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/custom_button.dart';
import 'package:covid_19_tracker/widgets/gridBox.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:covid_19_tracker/widgets/platform_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class IndiaStats extends StatefulWidget {
  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  Box indiaDataBox;
  List indiaCachedData;
  List indiaData;
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
      indiaDataBox = Hive.box(HiveBoxes.stateData);
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
      Fluttertoast.showToast(
        msg: 'No Internet',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('India\'s Stats'),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () => updateData(),
        showChildOpacityTransition: false,
        height: 60.0,
        animSpeedFactor: 5.0,
        color: Theme.of(context).accentColor,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CustomHeadingWidget(title: 'Overall Stats...'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),
                      child: CustomRaisedButton(
                        title: 'Statewise',
                        onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) {
                              return IndiaStatewise(
                                indiaData: indiaData,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<bool>(
                  stream: bloc.indiaDataLoadingStream,
                  initialData: true,
                  builder: (context, snapshot) {
                    return _buildContent(snapshot.data);
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                InfoWidget(),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 20.0,
                  alignment: Alignment.bottomCenter,
                  child: AutoSizeText(
                    'WE STAND TOGETHER TO FIGHT WITH THIS',
                    maxLines: 1,
                    minFontSize: 12.0,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isLoading) {
    if (isLoading && (indiaDataBox?.isEmpty ?? true)) {
      return Container(
        height: MediaQuery.of(context).size.width * 1.25,
        child: CustomProgressIndicator(),
      );
    }
    indiaData = isLoading ? indiaCachedData : bloc.indiaData;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                count: NumberFormatter.formatString(indiaData[0].confirmed),
                boxColor: Colors.red[200],
                textColor: Colors.red[900],
              ),
              GridBox(
                title: 'ACTIVE',
                count: NumberFormatter.formatString(indiaData[0].active),
                boxColor: Colors.blue[200],
                textColor: Colors.blue[900],
              ),
              GridBox(
                title: 'DEATHS',
                count: NumberFormatter.formatString(indiaData[0].deaths),
                boxColor: Colors.grey,
                textColor: Colors.grey[900],
              ),
              GridBox(
                title: 'RECOVERED',
                count: NumberFormatter.formatString(indiaData[0].recovered),
                boxColor: Colors.green[300],
                textColor: Colors.green[900],
              ),
            ],
          ),
        ),
        const CustomHeadingWidget(title: 'Visuals'),
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
              total: double.tryParse(indiaData[0].confirmed),
              active: double.tryParse(indiaData[0].active),
              recovered: double.tryParse(indiaData[0].recovered),
              deaths: double.tryParse(indiaData[0].deaths),
              totalColor: Colors.red[400],
              activeColor: Colors.blue[400],
              recoveredColor: Colors.green[300],
              deathsColor: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }
}
