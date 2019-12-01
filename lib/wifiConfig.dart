

import 'package:flutter/material.dart';
import 'WiFiArguments.dart';
import 'package:http/http.dart' as http;

class WifiConfig extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<WifiConfig> {

  var isLoading = false;
  WiFiArguments args;
  TextEditingController passwordController = new TextEditingController();

  _fetchData() async {

    setState(() {
      isLoading = true;
    });
//    Navigator.pop(context);
//    var url = new Uri.http("192.168.4.1", '/wifisave?s=lukasz&p=tajne123');

    try {
      String url = 'http://192.168.4.1/wifisave?s=${args.wifiName}&p=${passwordController.text}';
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
  //      print(response.body.toString());
        print("odpowiedz set");
        String url2 = 'http://192.168.4.1/close?';
        final response2 = await http.get(url2);
        if (response2.statusCode == 200) {
            print("odpowiedz close");
            setState(() {
              isLoading = false;
            });
        }
      }
      else {
        throw Exception('Failed to connect');
      }
    } catch (Exception) {

    }
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  Widget getLoading(){
    return Center(
      child: Container(
        width: 250,
        height: 350,
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom:8,top: 10),
                child:Text("Laczenie",
                style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(),
              Spacer(),
              CircularProgressIndicator(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor:Color(0xff0B1028),
      appBar: AppBar(
        backgroundColor:Color(0xff444c74),
        title: Text("Wpisz haslo"),
      ),
      body: isLoading
          ? getLoading()
          : Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${args.wifiName}',
                            style: TextStyle(
                              fontSize: 20
                            ),
                            ),
                            Spacer(),
                            Icon(Icons.lock_outline)
                          ],
                        ),
                        new Divider(),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'password'
                          ),
                        ),
                        new Divider(),
                        RaisedButton(
                          onPressed: _fetchData,
                          child: Text(
                              'Polacz',
                              style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
