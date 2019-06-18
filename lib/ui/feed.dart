import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naudi_mock/model/colors.dart';
import 'package:naudi_mock/model/nerd.dart';
import 'package:naudi_mock/ui/feed-detail.dart';

import 'floating-bar-helpers.dart';

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
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
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
                if (nerds.length > index) {
                  Nerd nerd = nerds[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: CircleAvatar(
                      child: Text('U'),
                    ),
                    title: Text(
                      nerd.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      nerd.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          maintainState: true,
                          builder: (context) => FeedDetail(
                                title: nerd.title,
                                content: nerd.content,
                                index: index,
                              ),
                        ),
                      );
                    },
                  );
                } else
                  return null;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Nerd nerd, int index) {
    return InkWell(
      onTap: () {
        print('wooow');
//        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
//            .copyWith(statusBarIconBrightness: Brightness.dark));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedDetail(
                  title: nerd.title,
                  index: index,
                  content: nerd.content,
                ),
            maintainState: true,
          ),
        );
      },
      customBorder: Border(
        right: BorderSide.none,
        left: BorderSide.none,
        top: BorderSide.none,
        bottom: BorderSide(
          color: darkTextColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[Icon(Icons.person_outline), Text(nerd.user)],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                flightShuttleBuilder: (context, anim, a, ctx, ctt) => Text(
                      nerd.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                child: Text(
                  nerd.title,
                  style: Theme.of(context).textTheme.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                tag: index.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                flightShuttleBuilder: (context, anim, a, ctx, ctt) => Text(
                      nerd.content,
                      style: Theme.of(context).textTheme.body1,
                    ),
                tag: 'content ${index.toString()}',
                child: Text(
                  nerd.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(88.0),
            ),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('Music'),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  final res = nerds.map((n) => n.title).toList();

  final recents = nerds.map((n) => n.title).toList().sublist(0, 9);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty ? recents : res;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.location_city),
            title: Text(suggestionList[index]),
          ),
      itemCount: suggestionList.length,
    );
  }
}
