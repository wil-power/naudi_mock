import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:naudi_mock/model/colors.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double sidePadding;

  final bool expanded;

  SliverAppBarDelegate({
    @required this.sidePadding,
    @required this.leading,
    @required this.automaticallyImplyLeading,
    @required this.title,
    @required this.trailing,
    @required this.elevation,
    @required this.backgroundColor,
    @required this.floating,
    @required this.pinned,
    @required this.snapConfiguration,
    @required this.collapsedHeight,
    @required this.topPadding,
    @required this.expanded,
  });

  final Widget trailing;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final double elevation;
  final bool floating;
  final Widget leading;
  final bool pinned;
  final Widget title;
  final double collapsedHeight;
  final double topPadding;

  @override
  double get minExtent => collapsedHeight ?? (topPadding + kToolbarHeight);

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  @override
  double get maxExtent => math.max(topPadding + (kToolbarHeight), minExtent);

  @override
  bool shouldRebuild(covariant SliverAppBarDelegate oldDelegate) {
    return leading != oldDelegate.leading ||
        automaticallyImplyLeading != oldDelegate.automaticallyImplyLeading ||
        title != oldDelegate.title ||
        trailing != oldDelegate.trailing ||
        elevation != oldDelegate.elevation ||
        topPadding != oldDelegate.topPadding ||
        collapsedHeight != oldDelegate.collapsedHeight ||
        backgroundColor != oldDelegate.backgroundColor ||
        pinned != oldDelegate.pinned ||
        floating != oldDelegate.floating ||
        snapConfiguration != oldDelegate.snapConfiguration;
  }

  @override
  String toString() {
    return '';
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = maxExtent - shrinkOffset;

    // // Truth table for `toolbarOpacity`:
    // // pinned | floating | bottom != null || opacity
    // // ----------------------------------------------
    // //    0   |    0     |        0       ||  fade
    // //    0   |    0     |        1       ||  fade
    // //    0   |    1     |        0       ||  fade
    // //    0   |    1     |        1       ||  fade
    // //    1   |    0     |        0       ||  1.0
    // //    1   |    0     |        1       ||  1.0
    // //    1   |    1     |        0       ||  1.0
    // //    1   |    1     |        1       ||  fade
    final double toolbarOpacity = !pinned || (floating)
        ? ((visibleMainHeight) / kToolbarHeight).clamp(0.0, 1.0)
        : 1.0;

    final Widget appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: toolbarOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: SafeArea(
          child: Material(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8.0),
            elevation: elevation,
            child: Center(
              child: !expanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                          leading ??
                              (Scaffold.of(context).hasDrawer &&
                                      automaticallyImplyLeading
                                  ? IconButton(
                                      icon: Icon(Icons.menu),
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                    )
                                  : null),
                          SizedBox(),
                          title,
                          SizedBox(),
                          trailing,
                        ])
                  : Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            leading ??
                                (Scaffold.of(context).hasDrawer &&
                                        automaticallyImplyLeading
                                    ? IconButton(
                                        icon: Icon(Icons.menu),
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                      )
                                    : null),
                            SizedBox(),
                            Flexible(child: title),
                            SizedBox(),
                            trailing,
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
    return AnimatedContainer(
      height: collapsedHeight,
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
//      width: MediaQuery.of(context).size.width,
      child: Center(
          child: floating
              ? _FloatingAppBar(child: Center(child: appBar))
              : appBar),
      duration: Duration(milliseconds: 300),
    );
  }
}

class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

// A wrapper for the widget created by _SliverAppBarDelegate that starts and
/// stops the floating appbar's snap-into-view or snap-out-of-view animation.
class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    _position = Scrollable.of(context)?.position;
    if (_position != null)
      _position.isScrollingNotifier.addListener(_isScrollingListener);
  }

  @override
  void dispose() {
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    super.dispose();
  }

  RenderSliverFloatingPersistentHeader _headerRenderer() {
    return context.ancestorRenderObjectOfType(
        const TypeMatcher<RenderSliverFloatingPersistentHeader>());
  }

  void _isScrollingListener() {
    if (_position == null) return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final RenderSliverFloatingPersistentHeader header = _headerRenderer();
    if (_position.isScrollingNotifier.value)
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    else
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
