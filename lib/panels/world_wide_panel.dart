import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:covid_19/home.dart';
import 'package:covid_19/Widgets/info_card.dart';
import 'package:covid_19/localization/localiztion_methods.dart';
import 'package:intl/number_symbols_data.dart';

class worldWidePanel extends StatelessWidget {
final Map worldWide;
final Map historyData;

  const worldWidePanel({Key key,this.worldWide, this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     child: GridView(
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 2
       ),
       children: <Widget>[
           InfoCard(
            title: 'CONFIRMED',
            iconColor:Colors.red,
            effectecNum: worldWide['cases'],
            press: (){},
            cardColor: Colors.red[100],
            historyData: historyData,
          ),
          InfoCard(
            title: 'ACTIVE',
            iconColor: Colors.blue,
            effectecNum:worldWide['active'],
            press: (){},
            cardColor: Colors.blue[100],
            historyData: null,
          ),
          InfoCard(
            title: 'RECOVERD',
            iconColor: Colors.green,
            effectecNum: worldWide['recovered'],
            press: (){},
            cardColor: Colors.green[100],
            historyData: historyData,
          ),
          InfoCard(
            title: 'DEATHS',
            iconColor: Colors.black,
            effectecNum: worldWide['deaths'],
             press: (){},
             cardColor:Colors.grey[400] ,
             historyData: historyData,
          ),
          
       ]
     ,),
    );
  }
}


class StatusPanel extends StatelessWidget {
final Color panelColor;
final Color textColor;
final String title;
final String count;




  StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);




  @override
  Widget build(BuildContext context) {
double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width/2,
      color: panelColor,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
            Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:16,
              color: textColor
            ),
            ),
            Text(count,
             style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:16,
              color: textColor
            ),)
       ],
       ),
    );
  }
}