import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/data/hive_boxes.dart';
import 'package:covid_19_tracker/widgets/countryCard.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CountryWiseStats extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<CommonBloc>(
      create: (_) => CommonBloc(),
      child: CountryWiseStats(),
    );
  }

  @override
  _CountryWiseStatsState createState() => _CountryWiseStatsState();
}

class _CountryWiseStatsState extends State<CountryWiseStats> {
  List countriesData;
  List countriesCachedData;
  Box countryDataBox;

  Widget _buildContent(
    CommonBloc bloc,
    bool isLoading,
    double height,
  ) {
    if (countryDataBox.isEmpty && isLoading) {
      return CustomProgressIndicator();
    }
    countriesData = isLoading ? countriesCachedData : bloc.countriesData;
    return ListView.builder(
      itemCount: countriesData.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: countriesData,
          height: height,
          index: index,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCachedData();
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    bloc.getCountriesData();
  }

  Future<void> getCachedData() async {
    countryDataBox = Hive.box(HiveBoxes.countriesData);
    countriesCachedData = countryDataBox?.values?.last;

    print('Most Recent CountriesData: ${countriesCachedData.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (countriesData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    countriesData,
                    height,
                  ),
                );
              }
            },
          ),
        ],
        title: const Text(
          'COUNTRY-WISE STATS',
        ),
      ),
      body: StreamBuilder<bool>(
        stream: bloc.countriesDataLoadingStream,
        initialData: true,
        builder: (context, snapshot) {
          return _buildContent(
            bloc,
            snapshot.data,
            height,
          );
        },
      ),
    );
  }
}

class Search extends SearchDelegate {
  final List countryData;
  final double height;

  Search(this.countryData, this.height);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryData
        : countryData
            .where(
              (element) => element.country
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: countryData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          countryData: suggestionList,
          height: height,
          index: index,
        );
      },
    );
  }
}
