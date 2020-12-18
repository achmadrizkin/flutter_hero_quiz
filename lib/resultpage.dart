import "package:flutter/material.dart";

import 'home.dart';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key key, @required this.marks}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState(marks);
}

class _ResultPageState extends State<ResultPage> {
  String messeges;
  String marksPoint;

  @override
  void initState() {
    if (marks < 50) {
      messeges = "no, you are a villager !\n";
      marksPoint = "$marks";
    } else if (marks < 100) {
      messeges = "no, you are a prince !\n";
      marksPoint = "$marks";
    } else {
      messeges = "yes, you are a hero !\n";
      marksPoint = "$marks";
    }

    super.initState();
  }

  int marks;
  _ResultPageState(this.marks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment(-0.5, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              color: Colors.white,
              child: new Text("am i a hero ?",
                  style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontFamily: 'PopinsExBold')),
            ),
            SizedBox(height: 60),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(messeges,
                    style: new TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontFamily: 'PopinsExBold')),
              ),
            ),
            Container(
              child: Text(marksPoint,
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'PopinsExBold')),
            ),
            Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.height / 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: new Text(
                          "Continue",
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: 'PopinsExBold'),
                        )),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
