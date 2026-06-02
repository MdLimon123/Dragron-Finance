import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE5E7EB), width: 1.08),
        ),
        boxShadow: [
          // Shadow 1
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.10),
            offset: const Offset(0, 0.98),
            blurRadius: 1.96,
            spreadRadius: -0.98,
          ),
          // Shadow 2
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.10),
            offset: const Offset(0, 2.94),
            blurRadius: 2.94,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Image.asset(
        'assets/image/app_logo_fill.png',
        height: 25,
        width: 25,
        fit: BoxFit.contain,
      ),
    );
  }
}
