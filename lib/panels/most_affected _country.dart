// import 'dart:convert';

// import 'package:covid_19/data_source.dart';
// import 'package:flutter/material.dart';
// import 'package:covid_19/data_source.dart';
// import 'package:covid_19/detiles.dart';
// import 'package:covid_19/localization/localiztion_methods.dart';

// class MostAffectedPanel extends StatelessWidget {

// final List countryData;


//   const MostAffectedPanel({
//     Key key,
//     this.countryData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        
//            child: Row(
//              children: <Widget>[
//              Image.network(countryData[index]['countryInfo']['flag'],height: 30,width: 30,)    ,
//              SizedBox(width: 10,),
//              Text(countryData[index]['country']
//              ,style: TextStyle(fontWeight: FontWeight.bold),),
//              SizedBox(width: 10,),
//              Text(countryData[index]['deaths'].toString(),
//              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
//             SizedBox(width: 10,),
//            GestureDetector(
               
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Detiles(countryData[index]['country'])));
//                       },
//                       child: Container(
                      
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: primaryBlack,
//                         ),
//                         child: Text(
//                            getTranslated(context,'Detailes'),
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
             
             
//             ],
//            ),
             
//           );
//         },
//         itemCount: 5,
//       ),
//     );
//   }
// }
