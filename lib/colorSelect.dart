import 'package:flutter/material.dart';
import "WheelPickerPage.dart";
import 'DeviceArguments.dart';

class ColorPage extends StatefulWidget {

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  int _counter = 0;


  DeviceArguments args;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Color"),
        backgroundColor:Color(0xff444c74),
      ),
      backgroundColor:Color(0xff0B1028),
      body: Center(
      child: SingleChildScrollView(
      child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Container(
//          color:Color(0xff444c74),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

//              WheelPickerPage(address: args.wifiAddress),
            ],
          ),
        ),
      ),
      ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
