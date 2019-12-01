import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'WiFiArguments.dart';
import 'wifiConfig.dart';
import 'package:http/http.dart' as http;
import 'wifiAp.dart';

class WifiSelectPage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WifiSelectPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<WiFiAp> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var url = new Uri.http("192.168.4.1", "/scan");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body.toString());
      list = (json.decode(response.body)['Access_Points'] as List)
          .map((data) => new WiFiAp.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor:Color(0xff0B1028),
        appBar: AppBar(
          backgroundColor:Color(0xff444c74),
          title: Text("Wybierz siec WIFI"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color:Color(0xff444c74),
                child: ListTile(
                  leading: Icon(Icons.network_wifi,color: Colors.white,),
                  contentPadding: EdgeInsets.all(10.0),
                  title: new Text(
                    list[index].SSID,
                    style: TextStyle(fontSize: 18,color: Colors.white,),
                  ),
                  trailing: Text(
                    list[index].Quality + "%",
                    style: TextStyle(fontSize: 18,color: Colors.white,),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WifiConfig(),
                        settings: RouteSettings(
                          arguments: WiFiArguments(
                            list[index].SSID,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }));
  }
}

