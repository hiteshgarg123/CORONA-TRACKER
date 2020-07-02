import 'package:flutter/material.dart';

import 'package:covid_19_tracker/data/datasource.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Fetching Data , Please wait',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          SpinKitCircle(
            color: primaryBlack,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}
