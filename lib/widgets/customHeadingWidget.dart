import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomHeadingWidget extends StatelessWidget {
  final String title;

  const CustomHeadingWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: AutoSizeText(
        title,
        maxLines: 1,
        minFontSize: 18.0,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
