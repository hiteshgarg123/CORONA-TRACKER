import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fetching Data, Please wait',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 25.0,
          ),
          SpinKitCircle(
            color: Theme.of(context).buttonColor,
            size: MediaQuery.of(context).size.width * 0.1,
          ),
        ],
      ),
    );
  }
}
