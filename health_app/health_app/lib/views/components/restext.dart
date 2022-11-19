import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:health_app/fitness_app/fitness_app_theme.dart';
import 'package:health_app/main.dart';

class ResText extends StatelessWidget {
  final Color iColor;
  final String iText;
  const ResText({
    super.key,
    required this.iColor,
    required this.iText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 3),
      child: Text(
        iText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: FitnessAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: iColor,
        ),
      ),
    );
  }
}
