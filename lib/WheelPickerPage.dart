import "package:flutter/material.dart";
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:http/http.dart' as http;

class WheelPickerPage extends StatefulWidget {
  WheelPickerPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  WheelPickerPageState createState() => new WheelPickerPageState();
}

class WheelPickerPageState extends State<WheelPickerPage> {
  HSVColor color = HSVColor.fromColor(Colors.blue);
  int licznik = 0;
//  String url = 'http://10.0.0.140';
  String url = 'http://';
  bool finish = true;
  double _sliderValue = 10.0;

  initState() {
    super.initState();
    url = widget.url;
  }

  void onChanged(HSVColor color)
  {
    this.color = color;
    this.licznik++;

    makeUrl();
  }

  void makeUrl(){
    String finalurl = url + "/set?c=" +  (this.color.toColor().value & 0x00ffffff).toRadixString(16) ;

    makeRequest(finalurl);
    print(finalurl);
  }

  void makeRequest(String url) async {
    if(finish)
      {
        finish = false;
        var response = await http.post(url);
        finish = true;
      }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            width: 260,
            child: new Card(
                color:Color(0xff444c74),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 2.0,
                child: new Padding(
                    padding: const EdgeInsets.all(10),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "wybierz kolor",
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          new Divider(),
                          new FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: this.color.toColor(),
                          ),
                          new Divider(),

                          ///---------------------------------
                          new Container(
                              width: 222,
                              height: 222,
                              child: new WheelPicker(
                                color: this.color,
                                onChanged: (value) =>
                                    super.setState(() => this.onChanged(value)),
                              )),


                          ///---------------------------------
                        ]
                    )
                )
            )
        )
    );
  }
}
