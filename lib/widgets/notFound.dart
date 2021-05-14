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
          Image.asset(
            'assets/images/not_found.png',
            height: MediaQuery.of(context).size.width * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
