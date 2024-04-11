import 'package:flutter/material.dart';
import 'package:pneumonia_detection/features/home/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/screens/screens.dart';

class MenuItem {

  final String title;
  final String subTitle;
  final String link;
  final IconData icon;
  final int value;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
    required this.value
  });

}

const appMenuItem = <MenuItem> [
  MenuItem(
    title: 'Home',
    subTitle: 'Menu',
    link: HomeScreen.routeName,
    icon: Icons.countertops,
    value: 0,
  ),

  MenuItem(
    title: 'Pneumonia detection',
    subTitle: 'Scanear radiografia de torax',
    link: UploadRadiographyScreen.routeName,
    icon: Icons.smart_button_outlined,
    value: 1,
  ),
];