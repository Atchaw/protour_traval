import 'package:flutter/material.dart';
import './visa_form.dart';
import 'package:protour_traval/app_theme.dart';

class VisaHomeScreen extends StatefulWidget {
  @override
  _VisaHomeScreenState createState() => _VisaHomeScreenState();
}

class _VisaHomeScreenState extends State<VisaHomeScreen>
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
        color: AppTheme.buildLightTheme().backgroundColor,
        child: VisaForm(),
      ),
    );
  }
}
