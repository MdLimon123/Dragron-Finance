import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    required this.onTap,
    required this.text,
    this.isLoading,
    this.icon,
    this.width,
    this.height,
  });

  final VoidCallback onTap;
  final String text;
  final bool? isLoading;
  final Widget? icon;
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final loading = isLoading ?? false;
    final borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: color == null
              ? const LinearGradient(
                  colors: [Color(0xFFA41F13), Color(0xFF292F36)],
                )
              : null,
          borderRadius: borderRadius,
        ),
        child: ElevatedButton(
          onPressed: loading ? () {} : onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            minimumSize: Size(width ?? Get.width, height ?? 48),
          ),
          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style:
                          textStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (icon != null) ...[const SizedBox(width: 8), icon!],
                  ],
                ),
        ),
      ),
    );
  }
}
