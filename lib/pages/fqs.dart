import 'package:covid_19/localization/localiztion_methods.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/data_source.dart';
class FQPage extends StatelessWidget {
  const FQPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context,'FAQS')),
        ),
        body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context,index){
          return ExpansionTile(
            title: Text( getLangCode(context) == ARABIC ? DataSource.ARquestionAnswers[index]['سؤال'] : DataSource.questionAnswers[index]['question'],
            ),
            children: <Widget>[
            
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text( getLangCode(context) == ARABIC ? DataSource.ARquestionAnswers[index]['جواب'] : DataSource.questionAnswers[index]['answer']),
              )
              ,
            ],
            );
        },),
    );
  }
}