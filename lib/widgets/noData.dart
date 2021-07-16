import 'package:covid_19_tracker/utils/scroll_behaviour.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title;

  const NoData({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/not_found.png',
                height: MediaQuery.of(context).size.width * 0.75,
                width: MediaQuery.of(context).size.width * 0.75,
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
