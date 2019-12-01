import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'device.dart';
import 'DeviceArguments.dart';
import 'colorSelect.dart';
import 'WifiSelect.dart';
import 'choinkaScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Color demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _licznik = 0;

  List<DeviceInfo> list = List();
  var isLoading = true;

  Future<void> _getmdns() async {

    print('Done.');
  }

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    var addressesIListenFrom = InternetAddress('255.255.255.255');
    int portIListenOn = 4210; //0 is random
    RawDatagramSocket.bind(addressesIListenFrom, portIListenOn)
        .then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
      udpSocket.forEach((RawSocketEvent event) {
        if(event == RawSocketEvent.read) {
          Datagram dg = udpSocket.receive();
          _licznik++;


          var li = list.where((i){
            bool stan = i.address == dg.address;
            return   stan;
          }).toList();

          if(li.length ==  0 ) {
            list.add(new DeviceInfo(
                name: new String.fromCharCodes(dg.data),
                address: dg.address
            )
            );
            print("message:" + new String.fromCharCodes(dg.data) + dg.address.address);
            setState(() {
              isLoading = false;
            });
          }

        }

      });
    });
  }

  Future<void> _refreshStockPrices() async
  {
    print('refreshing stocks...');
    list.clear();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff444c74),
        centerTitle: true,
        title: Text('Wybierz urzadzenie'),
      ),
      backgroundColor:Color(0xff0B1028),
      body: Center(

          child: isLoading ?
          Center(
            child: CircularProgressIndicator(),
          )
              : RefreshIndicator(
              onRefresh: _refreshStockPrices,
              child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color:Color(0xff444c74),
                  child: ListTile(
                    leading: Icon(
                        Icons.network_wifi,
                    color: Colors.white,),
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(
                      list[index].address.address,
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    trailing: Text(
                      list[index].name,
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenChoinka(),
//                          builder: (context) => ColorPage(),
                          settings: RouteSettings(
                            arguments: DeviceArguments(
                              list[index].address.address,
                            ),
                          ),
                        ),
                      );
                    },

                  ),
                );
              })
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WifiSelectPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
