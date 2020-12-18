import 'dart:async';
import './resultpage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GetJson extends StatelessWidget {
  String langname;
  GetJson(this.langname);
  String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    if (langname == "warior") {
      assettoload = "assets/warior.json";
    } else if (langname == "mage") {
      assettoload = "assets/mage.json";
    } else {
      assettoload = "assets/tank.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString(assettoload, cache: false),
        builder: (context, snapshot) {
          List mydata = json.decode(snapshot.data.toString());
          if (mydata == null) {
            return Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return QuizPage(mydata: mydata);
          }
        });
  }
}

class QuizPage extends StatefulWidget {
  final List mydata;

  QuizPage({Key key, @required this.mydata}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<QuizPage> {
  final List mydata;
  _QuizPageState(this.mydata);

  int marks = 0;
  int i = 1;
  int timer = 10;
  String showTimer = "10";

  bool cancelTimer = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 10;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ResultPage(marks: marks)));
      }
    });

    startTimer();
  }

  void checkAnswer(String k) {
    if (mydata[2]["1"] == mydata[1]["1"][k]) {
      marks = marks + 10;
    }
    setState(() {
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String k) {
    return InkWell(
      onTap: () => checkAnswer(k),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 12,
        child: Center(
            child: new Text(
          mydata[1][i.toString()][k],
          style: new TextStyle(
              fontSize: 24.0, color: Colors.black, fontFamily: 'PopinsExBold'),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.black,
                  content: Text(
                    "You Can't Go Back At This Stage",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'PopinsExBold'),
                  ),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'PopinsBold'),
                        ))
                  ],
                ));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment(-0.5, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                color: Colors.white,
                child: new Text(mydata[0][i.toString()],
                    style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontFamily: 'PopinsExBold')),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      choiceButton('a'),
                      SizedBox(
                        height: 20.0,
                      ),
                      choiceButton('b'),
                      SizedBox(
                        height: 20.0,
                      ),
                      choiceButton('c'),
                      SizedBox(
                        height: 20.0,
                      ),
                      choiceButton('d'),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: new Text(
                        showTimer,
                        style: new TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: 'PopinsExBold'),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
