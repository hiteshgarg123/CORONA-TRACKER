import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: AutoSizeText(
              StaticData.commonQuestions[index]['question']!,
              maxLines: 2,
              minFontSize: 12.0,
              maxFontSize: 16.0,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(StaticData.commonQuestions[index]['answer']!),
              ),
            ],
          );
        },
        itemCount: StaticData.commonQuestions.length,
      ),
    );
  }
}
