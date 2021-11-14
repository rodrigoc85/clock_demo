import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockScaffold extends StatefulWidget {
  final List<TabContent> pages;
  final String mainTitle;

  const ClockScaffold({
    Key? key,
    required this.pages,
    required this.mainTitle,
  }) : super(key: key);

  @override
  _ClockScaffoldState createState() => _ClockScaffoldState();
}

class _ClockScaffoldState extends State<ClockScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _tabController = TabController(vsync: this, length: widget.pages.length);
      _tabController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
                inactiveColor: CupertinoColors.systemGrey,
                activeColor: CupertinoColors.activeOrange,
                items: widget.pages
                    .map((page) => BottomNavigationBarItem(
                        icon: Icon(
                          page.icon,
                        ),
                        label: page.title))
                    .toList()),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(widget.pages[index].title),
                  trailing: _hasAction(index)
                      ? GestureDetector(
                          onTap: _actionHandler(index),
                          child: Icon(
                            _actionIcon(index),
                            size: 26,
                            color: CupertinoColors.activeOrange,
                          ),
                        )
                      : null,
                ),
                child: widget.pages[index].page,
              );
            })
        : Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicatorColor: Colors.orangeAccent,
                  controller: _tabController,
                  tabs: widget.pages
                      .asMap()
                      .map((i, page) => MapEntry(
                          i,
                          Tab(
                              icon: Icon(
                            page.icon,
                            color: (i == _tabController.index)
                                ? Colors.orangeAccent
                                : Colors.grey,
                          ))))
                      .values
                      .toList()),
              title: Text(widget.mainTitle),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: widget.pages.map((page) => page.page).toList(),
            ),
            floatingActionButton: _hasAction(_tabController.index)
                ? FloatingActionButton(
                    backgroundColor: Colors.orangeAccent,
                    onPressed: _actionHandler(_tabController.index),
                    child: Icon(
                      _actionIcon(_tabController.index),
                    ))
                : null);
  }

  bool _hasAction(int index) {
    return widget.pages[index].action != null;
  }

  _actionHandler(int index) {
    return widget.pages[index].action!.onTap;
  }

  IconData _actionIcon(int index) {
    return widget.pages[index].action!.icon;
  }
}

class ActionItem {
  IconData icon;
  Function onTap;

  ActionItem({
    required this.icon,
    required this.onTap,
  });
}

class TabContent {
  IconData icon;
  String title;
  Widget page;
  ActionItem? action;

  TabContent({
    required this.icon,
    required this.title,
    required this.page,
    this.action,
  });
}
