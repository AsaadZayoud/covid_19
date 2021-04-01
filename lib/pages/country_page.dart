import 'dart:convert';
import 'package:covid_19/data_source.dart';
import 'package:covid_19/detiles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_19/localization/localiztion_methods.dart';
import 'package:covid_19/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class CountryPage extends StatefulWidget {
  CountryPage({Key key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countriesData;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SearchBar searchBar;
//getTranslated(context,'Countriese_Status')

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text(getTranslated(context, 'Countriese_Status')),
        actions: [searchBar.getSearchAction(context)]);
  }

  List<Map> country = [];
  void onSubmitted(String value) {
    // ignore: unused_local_variable
    for (Map v in countriesData) {
      if (v['country'].toLowerCase() == value.toLowerCase()) {
        //  country=[v];
        country.add(v);

        print('$value the country is $v');
        break;
        // print(value.toLowerCase().substring(1,3));

      } else if (value.length < 2) {
        country.add(v);
        print("no country now");
      } else if (v['country'].toLowerCase().substring(0, 2) ==
          value.toLowerCase().substring(0, 2)) {
        country.add(v);
      } else {}
    }

    setState(() => countriesData = this.country);
    this.country = [];
  }

  _CountryPageState() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onClosed: () => featchCountriesData(),
      onChanged: onSubmitted,
      onCleared: () => featchCountriesData(),
    );
  }
  Map r = {'as': 'asaad', 'ss': 'ddd', 'zxzx': 'ss'};

  featchCountriesData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    featchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: countriesData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countriesData == null ? 0 : countriesData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color:
                          themeChange.darkTheme ? Colors.black : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: themeChange.darkTheme
                                ? Colors.grey[800]
                                : Colors.grey[100],
                            offset: Offset(0, 10),
                            blurRadius: 10)
                      ]),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              countriesData[index]['country'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countriesData[index]['countryInfo']['flag'],
                              height: 50,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                getTranslated(context, 'CONFIRMED') +
                                    '  ' +
                                    countriesData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                getTranslated(context, 'ACTIVE') +
                                    '  ' +
                                    countriesData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                getTranslated(context, 'RECOVERD') +
                                    '  ' +
                                    countriesData[index]['recovered']
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                getTranslated(context, 'DEATHS') +
                                    '  ' +
                                    countriesData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detiles(
                                      countriesData[index]['country'])));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryBlack,
                          ),
                          child: Text(
                            getTranslated(context, 'Detailes'),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
