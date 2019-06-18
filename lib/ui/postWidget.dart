import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PostWidget extends StatefulWidget {
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    /*SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor.withAlpha(200),
    );*/

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        heroTag: 'add',
        onPressed: () {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Title'),
                focusNode: FocusNode(),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                focusNode: FocusNode(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
