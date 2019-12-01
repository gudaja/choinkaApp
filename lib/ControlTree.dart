import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControllTree extends StatefulWidget {
  ControllTree({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _ControllTreeState createState() => _ControllTreeState();
}

class _ControllTreeState extends State<ControllTree> {

  bool finish = true;

  void makeUrl(String command) {
    String finalurl =  widget.url + command;
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('assets/images/christmas.png'),
                ),
              ),
            ),
            SizedBox(
                height: 150.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.brightness_7,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?b=+");
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.brightness_5,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?b=-");
                            });
                          },
                        ),
                      ],
                    ),
                    //druga kolunma
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.fast_forward,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?s=+");
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.fast_rewind,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?s=-");
                            });
                          },
                        ),
                      ],
                    ),
                    //trzecia kolunma
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?a=+");
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.stop,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?a=-");
                            });
                          },
                        ),
                      ],
                    ),
                    //czwarta kolunma
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.exposure_plus_1,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?k=+");
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.exposure_neg_1,
                            color: Colors.white,
                          ),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              makeUrl("/set?k=-");
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
