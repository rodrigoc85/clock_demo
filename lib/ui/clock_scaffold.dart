import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockScaffold extends StatelessWidget {
  final List<TabContent> pages;
  final String mainTitle;

  const ClockScaffold({
    Key? key,
    required this.pages,
    required this.mainTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
                items: pages
                    .map((page) => BottomNavigationBarItem(
                        icon: Icon(page.icon), label: page.title))
                    .toList()),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(pages[index].title),
                ),
                child: pages[index].page,
              );
            })
        : DefaultTabController(
            length: pages.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                    tabs: pages
                        .map((page) => Tab(icon: Icon(page.icon)))
                        .toList()),
                title: Text(mainTitle),
              ),
              body: TabBarView(
                children: pages.map((page) => page.page).toList(),
              ),
            ));
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
  List<ActionItem>? actions;

  TabContent({
    required this.icon,
    required this.title,
    required this.page,
    this.actions,
  });
}
