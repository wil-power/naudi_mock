import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:naudi_mock/model/colors.dart';
import 'package:naudi_mock/ui/feed.dart';
import 'package:naudi_mock/ui/home.dart';
import 'package:naudi_mock/ui/messages.dart';
import 'package:naudi_mock/ui/postWidget.dart';
import 'package:naudi_mock/ui/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildShrineTheme(context),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  ThemeData _buildShrineTheme(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: accentColor,
      primaryColor: primaryColor,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: accentColor,
        textTheme: ButtonTextTheme.normal,
      ),
      scaffoldBackgroundColor: primaryColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            textTheme: Theme.of(context).textTheme,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: darkIconTextColor,
                ),
          ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: accentColor,
      ),
      cardColor: primaryColor,
      textSelectionColor: accentColor,
      errorColor: Colors.red[800],
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: darkIconTextColor,
          ),
      // Todo: add the text themes (103)
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
      // todo add the icon themes (103)
      primaryIconTheme: base.iconTheme.copyWith(
        color: darkIconTextColor,
      ),
      hintColor: accentColor,
      // TODO decorate the inputs (103)
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hasFloatingPlaceholder: false,
        fillColor: Colors.purple[100],
        labelStyle: TextStyle(
          color: darkTextColor,
        ),
        hintStyle: TextStyle(
          color: darkTextColor,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(fontWeight: FontWeight.w500),
          title: base.title.copyWith(
            fontSize: 18.0,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        )
        .apply(
          // fontFamily: "Rubik",
          displayColor: darkTextColor,
          bodyColor: darkTextColor,
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
    switch (_index) {
      case 0:
        return Home();
      case 1:
        return Feed();
      case 2:
        return MessagesWidget();
      case 3:
        return SettingsWidget();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor.withAlpha(200),
    );
    return AnnotatedRegion(
      value: _currentStyle,
      child: Scaffold(
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
        floatingActionButton: _index != 3
            ? FloatingActionButton.extended(
                tooltip: 'Increment',
                label: _index != 2 ? Text("Nerd") : Text('New chat'),
                heroTag: 'add',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostWidget(),
                    ),
                  );
                },
              )
            : null,
        backgroundColor: primaryColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _incrementTab(int index) {
    setState(() {
      _index = index;
    });
  }
}
