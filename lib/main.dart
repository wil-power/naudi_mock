import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:naudi_mock/colors.dart';
import 'package:naudi_mock/colors.dart' as prefix0;
import 'package:naudi_mock/home.dart';
import 'package:naudi_mock/model/nerd.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

import 'colors.dart';
import 'feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: primaryColor,
    // ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        primaryColorDark: primaryColor,
        textSelectionColor: accentColor,
        backgroundColor: primaryColor,
        bottomAppBarColor: primaryColor,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: darkIconTextColor,
            ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _index = 0;

  Widget _whichView() {
    if (_index == 0) return Home();
    if (_index == 1) return Feed();

    return Home();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: accentColor,
        unselectedItemColor: darkIconTextColor,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            title: new Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: new Text('Settings'),
          ),
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),
      body: _whichView(),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Increment',
        label: Text("Nerd"),
      ),
      backgroundColor: primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _incrementTab(int index) {
    setState(() {
      _index = index;
    });
  }
}
