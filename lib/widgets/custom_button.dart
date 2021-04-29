import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomRaisedButton({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 7.0,
          vertical: 7.0,
        ),
        primary: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: AutoSizeText(
        title,
        maxLines: 1,
        minFontSize: 14.0,
        style: Theme.of(context).textTheme.headline2,
      ),
      onPressed: onPressed,
    );
  }
}
