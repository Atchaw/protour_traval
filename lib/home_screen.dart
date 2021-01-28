import 'package:protour_traval/bottom_navigation_view/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:protour_traval/bottom_navigation_view/bottom_bar_view.dart';
import 'package:protour_traval/app_theme.dart';

import 'package:protour_traval/custom_drawer/home_drawer.dart';
import 'package:protour_traval/custom_drawer/drawer_user_controller.dart';
import 'package:protour_traval/navigatoin_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    //tabBody =
    //MyDiaryScreen(animationController: animationController);
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

  //    child: Scaffold(
  //     backgroundColor: AppTheme.nearlyWhite,
  //     body: DrawerUserController(
  //       screenIndex: drawerIndex,
  //       drawerWidth: MediaQuery.of(context).size.width * 0.75,
  //       onDrawerCall: (DrawerIndex drawerIndexdata) {
  //         changeIndex(drawerIndexdata);
  //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
  //       },
  // screenView: screenView,
  //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
  //    ),
  //  ),
  //  );

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
            if (index == 0 || index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  //tabBody = null;
                  //  MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  // tabBody = null;
                  //TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
