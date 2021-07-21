import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String title;

  const NotFound({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/not_found.png',
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
            child: AutoSizeText(
              title,
              minFontSize: 18,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
