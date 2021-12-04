import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomRaisedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.015,
          vertical: MediaQuery.of(context).size.width * 0.02,
        ),
        primary: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      onPressed: onPressed,
      child: AutoSizeText(
        title,
        maxLines: 1,
        minFontSize: 18.0,
        maxFontSize: 22.0,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline2?.color,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
