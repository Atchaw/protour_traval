import 'package:flutter/material.dart';
import './assurance_form.dart';
import 'package:protour_traval/app_theme.dart';

class AssuranceHomeScreen extends StatefulWidget {
  @override
  _AssuranceHomeScreenState createState() => _AssuranceHomeScreenState();
}

class _AssuranceHomeScreenState extends State<AssuranceHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Container(
        padding: EdgeInsets.only(
          bottom: 62 + MediaQuery.of(context).padding.bottom,
        ),
        color: AppTheme.buildLightTheme().backgroundColor,
        child: AssuranceForm(),
      ),
    );
  }
}
