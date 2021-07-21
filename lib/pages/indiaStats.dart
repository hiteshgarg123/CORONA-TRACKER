import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/indiaData.dart';
import 'package:covid_19_tracker/pages/indiaStatewise.dart';
import 'package:covid_19_tracker/providers/india_data_provider.dart';
import 'package:covid_19_tracker/utils/enums/data_state.dart';
import 'package:covid_19_tracker/utils/formatter/number_formatter.dart';
import 'package:covid_19_tracker/widgets/customHeadingWidget.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:covid_19_tracker/widgets/custom_button.dart';
import 'package:covid_19_tracker/widgets/gridBox.dart';
import 'package:covid_19_tracker/widgets/infoWidget.dart';
import 'package:covid_19_tracker/widgets/noData.dart';
import 'package:covid_19_tracker/widgets/pieChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class IndiaStats extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<IndiaDataProvider>(
      create: (_) => IndiaDataProvider(),
      child: IndiaStats(),
    );
  }

  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  late final IndiaDataProvider indiaDataProvider;
  IndiaData? indiaData;

  @override
  void initState() {
    super.initState();
    indiaDataProvider = Provider.of<IndiaDataProvider>(context, listen: false);
    indiaDataProvider.getCachedData();
    indiaDataProvider.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 2.0,
        title: const Text("India's Stats"),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () => indiaDataProvider.updateData(),
        showChildOpacityTransition: false,
        height: 60.0,
        animSpeedFactor: 5.0,
        color: Theme.of(context).accentColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
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
                      onPressed: () {
                        if (indiaDataProvider.indiaData != null) {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) {
                                return IndiaStatewise(
                                  indiaData: indiaDataProvider.indiaData!,
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Consumer<IndiaDataProvider>(
                builder: (_, indiaDataProvider, __) {
                  switch (indiaDataProvider.dataState) {
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
                      return _buildContents(indiaDataProvider.indiaData!);
                    case DataLoadState.noInternet:
                      if (indiaDataProvider.indiaData == null) {
                        return const NoData(
                          title:
                              "Can't load data at the moment. Please try again later",
                        );
                      }
                      return _buildContents(indiaDataProvider.indiaData!);
                    case DataLoadState.overallFailure:
                      return const NoData(title: "Can't load data");
                    case DataLoadState.success:
                      return _buildContents(indiaDataProvider.indiaData!);
                    case DataLoadState.serverError:
                      return const NoData(
                        title: "Server Error. Please try again later",
                      );
                  }
                },
              ),
              const SizedBox(
                height: 5.0,
              ),
              const InfoWidget(),
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
      ),
    );
  }

  Widget _buildContents(IndiaData indiaData) {
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
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
            ),
            children: <Widget>[
              GridBox(
                title: 'TOTAL CASES',
                count: NumberFormatter.formatString(
                  indiaData.stateData[0].confirmed,
                ),
                boxColor: Colors.red[200]!,
                textColor: Colors.red[900]!,
              ),
              GridBox(
                title: 'ACTIVE',
                count:
                    NumberFormatter.formatString(indiaData.stateData[0].active),
                boxColor: Colors.blue[200]!,
                textColor: Colors.blue[900]!,
              ),
              GridBox(
                title: 'DEATHS',
                count:
                    NumberFormatter.formatString(indiaData.stateData[0].deaths),
                boxColor: Colors.grey,
                textColor: Colors.grey[900]!,
              ),
              GridBox(
                title: 'RECOVERED',
                count: NumberFormatter.formatString(
                    indiaData.stateData[0].recovered),
                boxColor: Colors.green[300]!,
                textColor: Colors.green[900]!,
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
              total: double.tryParse(indiaData.stateData[0].confirmed)!,
              active: double.tryParse(indiaData.stateData[0].active)!,
              recovered: double.tryParse(indiaData.stateData[0].recovered)!,
              deaths: double.tryParse(indiaData.stateData[0].deaths)!,
              totalColor: Colors.red[400]!,
              activeColor: Colors.blue[400]!,
              recoveredColor: Colors.green[300]!,
              deathsColor: Colors.grey[400]!,
            ),
          ),
        ),
      ],
    );
  }
}
