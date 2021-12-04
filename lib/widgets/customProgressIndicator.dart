import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Fetching Data, Please wait',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          height: 25.0,
        ),
        SpinKitCircle(
          color: Theme.of(context).colorScheme.background,
          size: MediaQuery.of(context).size.width * 0.12,
        ),
      ],
    );
  }
}
