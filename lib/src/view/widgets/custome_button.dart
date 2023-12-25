import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.width,
      this.height,
      this.isEnabled = true,
      this.titleFontSize = 18,
      this.backgroundColor,
      this.icon});
  final String title;
  final double? width, height;
  final void Function() onTap;
  final bool isEnabled;
  final double titleFontSize;
  final Color? backgroundColor;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: isEnabled
                  ? backgroundColor ?? AppColors.primaryColor
                  : Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        icon!,
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  : const SizedBox(),
              // const Spacer(
              //   flex: 1,
              // ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
