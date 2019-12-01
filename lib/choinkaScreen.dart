import 'package:collor/ControlTree.dart';
import 'package:flutter/material.dart';
import 'DeviceArguments.dart';
import 'package:http/http.dart' as http;
import 'placeHolder.dart';
import 'WheelPickerPage.dart';

class ScreenChoinka extends StatefulWidget {
  @override
  _ScreenChoinkaState createState() => _ScreenChoinkaState();
}

class _ScreenChoinkaState extends State<ScreenChoinka> {
  DeviceArguments args;
  bool finish = true;
  String url = '';
  int _currentIndex = 0;

  List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.red),
  ];

  void makeUrl(String command) {
    String finalurl = url + command;
    makeRequest(finalurl);
    print(finalurl);
  }

  void makeRequest(String url) async {
    if (finish) {
      finish = false;
      var response = await http.post(url);
      finish = true;
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if(index == 1) {
        makeUrl("/set?a=-&m=0");
      }else{
        makeUrl("/set?a=+");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    url = 'http://' + args.wifiAddress;

    _children = [
      ControllTree(url: url),
      WheelPickerPage(url: url)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff444c74),
      ),
      backgroundColor: Color(0xff0B1028),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        backgroundColor: Color(0xff444c74),
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: Colors.white,),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.palette, color: Colors.white,),
            title: new Text(''),
          ),
        ],
      ),
      body: _children[_currentIndex], // new,
    );
  }
}
