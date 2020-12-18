import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/quizpages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget customCard(String langname) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      GetJson(langname))); //rubah ke GetJson()
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 11,
              child: Center(
                  child: new Text(
                langname,
                style: new TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontFamily: 'PopinsExBold'),
              )),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            alignment: Alignment(-0.5, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.white,
            child: new Text("know yourself.",
                style: new TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontFamily: 'PopinsExBold')),
          ),
          SizedBox(height: 80),
          customCard("warior"),
          customCard("mage"),
          customCard("tank"),
        ],
      ),
    );
  }
}
