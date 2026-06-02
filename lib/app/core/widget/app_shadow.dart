import 'package:flutter/widgets.dart';

class AppShadow {
  AppShadow._();

  static List<BoxShadow> get soft => [
        BoxShadow(
          color: Color(0xFF000000).withValues(alpha: 0.10),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: Color(0xFF000000).withValues(alpha: 0.10),
          offset: Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
        ),
      ];
}