import 'package:flutter/material.dart';

final _navKey = GlobalKey<NavigatorState>();

GlobalKey<NavigatorState> get navKey => _navKey;

NavigatorState? get navigator => _navKey.currentState;

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
Widget setHeight(double height) => SizedBox(height: height);

Widget setWidth(double width) => SizedBox(width: width);
final List<Color> gridColors = [
  const Color(0xFFAAC9BF),
  const Color(0xFFD8EBFD),
  const Color(0xFFFFE0DD),
  const Color(0xFFFFF3D9),
];
