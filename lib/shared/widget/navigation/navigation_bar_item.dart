import 'package:flutter/material.dart';

class TitledNavigationBarItem {
  final String title;
  final String icon;
  final bool showBadge;
  final dynamic badgeContent;
  final Color backgroundColor;
  final bool visible;

  TitledNavigationBarItem({
    @required this.icon,
    @required this.title,
    this.backgroundColor = Colors.white,
    this.visible,
    this.showBadge,
    this.badgeContent
  });
}
