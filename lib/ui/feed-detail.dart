import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:naudi_mock/model/colors.dart';
import 'package:naudi_mock/model/nerd.dart';

class FeedDetail extends StatefulWidget {
  final String title;
  final int index, commentCount;

  final String user, content;

  const FeedDetail(
      {Key key,
      this.title,
      this.index,
      this.content,
      this.user,
      this.commentCount})
      : super(key: key);

  @override
  _FeedDetailState createState() {
    return _FeedDetailState(
        title: this.title,
        index: this.index,
        content: this.content,
        user: this.user,
        commentCount: this.commentCount);
  }
}

class _FeedDetailState extends State<FeedDetail> {
  final String title;
  final int index, commentCount;

  final String user, content;

  _FeedDetailState(
      {this.title, this.index, this.content, this.user, this.commentCount});

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor.withAlpha(200),
    );

    return AnnotatedRegion(
      value: _currentStyle,
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {},
        //   ),
        // ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.directions_run),
                        onPressed: () {},
                      )
                    ],
                    title: Hero(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      tag: index.toString(),
                    ),
                    floating: true,
                    brightness: Brightness.light,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < nerds.length) {
                          if (index == 0) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  subtitle: Text(content),
                                ),
                                Divider(),
                                // Text('Comments'),
                              ],
                            );
                          } else
                            return ListTile(
                              title: Text('comment $index'),
                              leading: Icon(Icons.person_outline),
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      color: accentColor,
                      icon: Icon(Icons.tag_faces),
                      onPressed: () {},
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Comment',
//                        border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      color: accentColor,
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // body: Material(
        //   color: primaryColor,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Hero(
        //           tag: index.toString(),
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               title,
        //               textAlign: TextAlign.start,
        //               style: Theme.of(context).textTheme.display1.copyWith(
        //                     color: darkTextColor,
        //                   ),
        //             ),
        //           ),
        //         ),
        //         Hero(
        //           tag: 'content ${index.toString()}',
        //           child: Text(
        //             content,
        //             textAlign: TextAlign.start,
        //             style: Theme.of(context).textTheme.body1,
        //           ),
        //         ),
        //         Divider(),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: <Widget>[
        //             IconButton(
        //               tooltip: 'up vote',
        //               icon: Icon(Icons.thumb_up),
        //               onPressed: () {},
        //             ),
        //             IconButton(
        //               tooltip: 'down vote',
        //               icon: Icon(Icons.thumb_down),
        //               onPressed: () {},
        //             ),
        //             IconButton(
        //               tooltip: 'follow',
        //               icon: Icon(Icons.directions_run),
        //               onPressed: () {},
        //             ),
        //           ],
        //         ),
        //         Divider(),
        //         Flexible(
        //           child: ListView(
        //             children: nerds
        //                 .map(
        //                   (nerd) => ListTile(
        //                         title: Text(nerd.title),
        //                       ),
        //                 )
        //                 .toList(),
        //           ),
        //         ),
        //         Card(
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: <Widget>[
        //                 IconButton(
        //                   icon: Icon(Icons.tag_faces),
        //                   onPressed: () {},
        //                 ),
        //                 Flexible(
        //                   child: TextField(
        //                     decoration: InputDecoration(labelText: 'comment'),
        //                   ),
        //                 ),
        //                 IconButton(
        //                   icon: Icon(Icons.send),
        //                   onPressed: () {},
        //                 ),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
