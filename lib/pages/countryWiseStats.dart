import 'package:covid_19_tracker/blocs/common_bloc.dart';
import 'package:covid_19_tracker/widgets/countryCard.dart';
import 'package:covid_19_tracker/widgets/customProgressIndicator.dart';
import 'package:flutter/material.dart';
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
  List worldWideData;

  Widget _buildContent(
    CommonBloc bloc,
    bool isLoading,
    double height,
  ) {
    if (isLoading) {
      return CustomProgressIndicator();
    }
    return ListView.builder(
      itemCount: isLoading == true ? 0 : bloc.worldData,
      itemBuilder: (context, index) {
        return CountryCard(
          worldWideData: bloc.countryData,
          height: height,
          index: index,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    bloc.getCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CommonBloc>(context, listen: false);
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (bloc.countryData != null) {
                showSearch(
                  context: context,
                  delegate: Search(
                    bloc.countryData,
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
              (element) => element['country']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: countryData == null ? 0 : suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
          worldWideData: suggestionList,
          height: height,
          index: index,
        );
      },
    );
  }
}
