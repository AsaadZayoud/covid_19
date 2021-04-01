import 'dart:convert';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data_source.dart';
import 'panels/world_wide_panel.dart';
import 'package:http/http.dart' as http;
import 'panels/info_panel.dart';
import 'pages/country_page.dart';
import 'localization/models.dart';
import 'localization/localiztion_methods.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'provider/dark_theme_provider.dart';
import 'package:animate_icons/animate_icons.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map location;

  Future<String> getCountry() async{
  http.Response response = await http.get("http://ip-api.com/json");
  location = json.decode(response.body);
  return location["country"];
}
  Map worldData;
  featchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
  
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;

  featchCountriesData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }

Map countryData;
    featchYourCountry() async {
        String country=await getCountry();
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/$country');
    setState(() {
  
      countryData = json.decode(response.body);
      print("Cuntry $countryData");
    });
  }


  Map historyData;

  featchHistoryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/historical/all');
    setState(() {
      historyData = json.decode(response.body);
    });
  }
IconData icon;


  @override
  void initState() {
   // controller = AnimationController();
    super.initState();
    featchWorldWideData();
    featchCountriesData();
    featchHistoryData();
    featchYourCountry();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool check=themeChange.darkTheme;
   
  IconData changeIcon(){
   
      icon  = check ? Icons.wb_sunny : Icons.brightness_2;
      check=!check;
      return icon;
  }
   return Scaffold(
      appBar:AppBar(
        centerTitle: false,
        title: Text(getTranslated(context,'COVID-19_Panel')),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(underline: SizedBox(),
            icon: Icon(Icons.language,),
            items: Language.LanguageList().map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                      Text(lang.flag,
                      style: TextStyle(fontSize: 20),
                      ),
                      Text(lang.name,)
              ],
              ),
            
            )
            ).toList(),
            onChanged: (Language lang){
              _changeLanguage(lang);
            },

            
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
  
            child: AnimatedIconButton(
        size: 20,
        
        onPressed: () {
           themeChange.darkTheme = !themeChange.darkTheme ;
         
        },
        
        duration: Duration(milliseconds: 200),
        startIcon:Icon( changeIcon()),
         
        endIcon:Icon(changeIcon()),
        
    ),
   
        )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 100,
                color: themeChange.darkTheme ? Colors.white70 : Colors.orange[100],
                child: Text(
                 getLangCode(context) == ARABIC ? DataSource.ARquote : DataSource.quote,
                  style: TextStyle(
                   color: themeChange.darkTheme ?  Colors.orange[100] : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context,'worldwide'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryBlack,
                        ),
                        child: Text(
                           getTranslated(context,'Regional'),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? CircularProgressIndicator()
                  : worldWidePanel(
                      worldWide: worldData,
                      historyData: historyData,
                    ),
                   
                    Row(
                  
               mainAxisAlignment: MainAxisAlignment.start,                   
                      children: [
                    
                   SizedBox(width: 20,),
                   countryData == null
                  ? CircularProgressIndicator() : Image.network(countryData['countryInfo']['flag'],height: 30,width: 30,)    ,
             SizedBox(width: 10,),
                        
                        Text(
                              getTranslated(context,'Your_country'),
                              style: TextStyle(
                                  fontSize: 16,
                                  
                                  fontWeight: FontWeight.bold),
                            ),
                      ],
                    ),
                      countryData == null
                  ? CircularProgressIndicator()
                  : worldWidePanel(
                      worldWide: countryData,
                      historyData: historyData,
                       ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     getTranslated(context,'Most_affected_Countries'),
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // countriesData == null
              //     ? Container()
              //     : MostAffectedPanel(
              //         countryData: countriesData,
              //       ),
              SizedBox(
                height: 5,
              ),
              InfoPanel(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  getTranslated(context,'WE_ARE_TOGETHER_IN_THIS') ,
                  style: TextStyle(
                      color: primaryBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage(Language lang) async {
     Locale _temp = await setLocale(lang.languageCode);
   
    MyApp.setLocale(context,_temp);
  }
   
}
