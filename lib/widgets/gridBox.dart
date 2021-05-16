import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GridBox extends StatelessWidget {
  final Color boxColor;
  final Color textColor;
  final String title;
  final String count;

  const GridBox({
    Key? key,
    required this.boxColor,
    required this.textColor,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(4),
      color: boxColor,
      height: 90,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            title,
            maxLines: 1,
            minFontSize: 16.0,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            count,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
