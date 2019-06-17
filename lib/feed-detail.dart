import 'package:flutter/material.dart';

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
  _FeedDetailState createState() => _FeedDetailState(
      title: this.title,
      index: this.index,
      content: this.content,
      user: this.user,
      commentCount: this.commentCount);
}

class _FeedDetailState extends State<FeedDetail> {
  final String title;
  final int index, commentCount;

  final String user, content;

  _FeedDetailState(
      {this.title, this.index, this.content, this.user, this.commentCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Hero(
          tag: index.toString(),
          child: Text(title),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: 'content ${index.toString()}',
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
