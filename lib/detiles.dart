import 'dart:convert';

/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with alternate colors per
// row, and a custom color for when the row is selected.




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// This is the stateful widget that the main application instantiates.
class Detiles extends StatefulWidget {
   Detiles(this.countryselect);
 String countryselect;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Detiles> {

  Map countrySelect;

    featchSelectedCountry(countryselect) async {
       
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/$countryselect');
        //https://corona.lmao.ninja/v2/countries/usa?yesterday=true
    setState(() {
  
      countrySelect = json.decode(response.body);
     
    });
  }
  Map countrySelectyesterday;
 featchSelectedCountryyesterday(countryselect) async {
       
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/$countryselect?yesterday=true');
        //https://corona.lmao.ninja/v2/countries/usa?yesterday=true
    setState(() {
  
      countrySelectyesterday = json.decode(response.body);
      
    });
  }

final  List data=['cases','todayCases','deaths','todayDeaths','recovered','todayRecovered','active','critical','casesPerOneMillion','deathsPerOneMillion','tests','testsPerOneMillion','population'];
 
  List<bool> selected = List<bool>.generate(13, (index) => false);
@override
void initState() { 
  super.initState();
  featchSelectedCountry(widget.countryselect);
  featchSelectedCountryyesterday(widget.countryselect);
}
  @override
  Widget build(BuildContext context) {

    return (this.countrySelect==null || this.countrySelectyesterday==null) ?  Center(
              child: CircularProgressIndicator(),
            ) : Scaffold(
        appBar: AppBar(title:Text(this.countrySelect['country'].toString()),
        leading: Image.network(this.countrySelect['countryInfo']['flag']),),
        body: SingleChildScrollView(
        scrollDirection:Axis.vertical ,
        
          child: SizedBox(
      
      width: double.infinity,
      child: DataTable(
          columns:  <DataColumn>[
             
            DataColumn(

              label: Text('#',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

            ),
            
            DataColumn(
       
              label: Text('today',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            DataColumn(label: Text('yesterday',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
          ],
         columnSpacing: 20,
         
          rows: List<DataRow>.generate(
            
            this.data.length,
            (index) => DataRow(
              
              color: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                // All rows will have the same selected color.
                if (states.contains(MaterialState.selected))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                // Even rows will have a grey color.
                if ( index % 2 == 0) return Colors.grey.withOpacity(0.3);
                return null; // Use default value for other states and odd rows.
              }),
              
              cells: [
                
                   DataCell(Text(this.data[index].toString())),
                DataCell(Text(this.countrySelect[this.data[index]].toString())),
             DataCell(Text(this.countrySelectyesterday[this.data[index]].toString()))
              ],
              selected: selected[index],
             
            ),
          ),
      ),
    ),
        )
    );
  }
}
