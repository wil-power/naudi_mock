import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naudi_mock/model/colors.dart';
import 'package:naudi_mock/model/nerd.dart';

import 'floating-bar-helpers.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  double _height = 80.0;
  AnimationController _proxyAnimation;

  double _elevation = 1.0;

  var _iconData = AnimatedIcons.menu_arrow;

  double _padding = 12.0;
  bool _expanded = false;

  TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController();
    _proxyAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
    _proxyAnimation?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: Home(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: false,
              delegate: SliverAppBarDelegate(
                sidePadding: _padding,
                expanded: _expanded,
                leading: IconButton(
                  icon: AnimatedIcon(
                    icon: _iconData,
                    progress: _proxyAnimation,
                  ),
                  onPressed: () {
                    if (_expanded) {
                      _proxyAnimation.reverse();
                      setState(() {
                        _height = 80.0;
                        _padding = 12.0;
                        _elevation = 1.0;
                        _expanded = false;
                      });
                    }
                  },
                ),
                automaticallyImplyLeading: false,
                title: _expanded
                    ? TextField(
                        controller: _textController,
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Find nerds',
                          hintStyle: Theme.of(context).textTheme.body1,
                        ),
                      )
                    : Container(
                        height: double.infinity,
                        child: Center(
                          child: InkWell(
                            child: Center(child: Text('Find nerds ...')),
                            onTap: () {
                              setState(() {
                                _elevation = 0.0;
                                _height = MediaQuery.of(context).size.height;
                                _proxyAnimation.forward();
                                _padding = 0.0;
                                _expanded = true;
                              });
                            },
                          ),
                        ),
                      ),
                trailing: !_expanded
                    ? CircleAvatar(
                        child: Text('W'),
                      )
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _textController.clear();
                        },
                      ),
                elevation: _elevation,
                backgroundColor: primaryColor,
                floating: true,
                pinned: false,
                snapConfiguration: null,
                collapsedHeight: _height,
                topPadding: 0.0,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recent threads',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: accentColor,
                      ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (nerds.length > index)
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: CircleAvatar(
                      child: Text('U'),
                    ),
                    title: Text(
                      nerds[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      nerds[index].content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    onTap: () {},
                  );
                else
                  return null;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
