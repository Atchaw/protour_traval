import 'package:protour_traval/bottom_navigation_view/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:protour_traval/bottom_navigation_view/bottom_bar_view.dart';
import 'package:protour_traval/app_theme.dart';

import 'package:protour_traval/hotel_booking/hotel_home_screen.dart';
import 'package:protour_traval/vole_ticket/vole_home_screen.dart';
import 'package:protour_traval/visa/visa_home_screen.dart';
import 'package:protour_traval/assurance/assurance_home_screen.dart';
import 'package:protour_traval/home/home_screen.dart';
import 'qr_code_screen.dart';
import 'payment.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomeScreen();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            shape: ContinuousRectangleBorder(
                borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            )),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.qr_code,
                    color: AppTheme.black,
                  ),
                  onPressed: () {
                    moveTo();
                  }),
            ],
            title: SizedBox(
              height: AppBar().preferredSize.height,
              width: AppBar().preferredSize.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 52, top: 6, bottom: 6),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ), //SafeArea
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => PaymentScreen(), //QrCodeScreen(),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = HomeScreen();
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = HotelHomeScreen();
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = TicketHomeScreen();
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = VisaHomeScreen();
                });
              });
            } else if (index == 4) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = AssuranceHomeScreen();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
