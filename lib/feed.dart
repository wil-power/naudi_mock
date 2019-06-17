import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:naudi_mock/feed-detail.dart';

import 'colors.dart';
import 'main.dart';
import 'model/nerd.dart';

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingSearchBar.builder(
        itemCount: nerds.length,
        itemBuilder: (BuildContext context, int index) {
          if (index >= nerds.length) {
            return null;
          } else
            return _buildItem(nerds[index], index);
        },
        trailing: CircleAvatar(
          child: Text("ND"),
        ),
        title: InkWell(
          child: Text('Find nerds..'),
          onTap: () {
            showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        onChanged: (String value) {
          print(value);
        },
        onTap: () {
          print('asdsdsd');
          showSearch(context: context, delegate: MySearchDelegate());
        },
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ),
      // SliverToBoxAdapter(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       "Recents",
      //       style: Theme.of(context).textTheme.body1.copyWith(
      //             color: accentColor,
      //           ),
      //     ),
      //   ),
      // ),
      //   SliverList(
      //     delegate: SliverChildBuilderDelegate(
      //       (context, index) {
      //         return _buildItem(nerds[index]);
      //       },
      //     ),
      //   )
    );
  }

  Widget _buildItem(Nerd nerd, int index) {
    return InkWell(
      onTap: () {
        print('wooow');
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
