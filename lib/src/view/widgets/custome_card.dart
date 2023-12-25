import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';

class CustomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color titleColor;
  const CustomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.titleColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 10, 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: AutoSizeText(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: titleColor,
                    fontSize: 20,
                  ),
                  minFontSize: 6,
                  wrapWords: false,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    subtitle,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                    ),
                    minFontSize: 6,
                    maxLines: 1,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
