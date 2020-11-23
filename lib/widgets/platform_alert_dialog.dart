import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String titleText,
  @required String contentText,
  @required String defaultActionButtonText,
}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: [
          CupertinoDialogAction(
            child: Text(defaultActionButtonText),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        titleText,
      ),
      content: SingleChildScrollView(
        child: Text(
          contentText,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(defaultActionButtonText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
