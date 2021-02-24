import 'dart:ui';
import 'package:protour_traval/vole_ticket/vole_list_view.dart';
import 'package:protour_traval/vole_ticket/model/ticket_list_data.dart';
import 'package:flutter/material.dart';
import 'package:protour_traval/app_theme.dart';
import 'vole_search.dart';
import 'info_screen.dart';

class TicketHomeScreen extends StatefulWidget {
  @override
  _TicketHomeScreenState createState() => _TicketHomeScreenState();
}

class _TicketHomeScreenState extends State<TicketHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<TicketListData> ticketList = TicketListData.ticketList;
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
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
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: Container(
                          color: AppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: ticketList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = ticketList.length > 10
                                  ? 10
                                  : ticketList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return TicketListView(
                                callback: () {
                                  moveTo();
                                },
                                ticketData: ticketList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: ticketList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          ticketList.length > 10 ? 10 : ticketList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return TicketListView(
                        callback: () {},
                        ticketData: ticketList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getTicketViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < ticketList.length; i++) {
      final int count = ticketList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        TicketListView(
          callback: () {},
          ticketData: ticketList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Widget getSearchBarUI() {
    return Container(
      color: AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SearchVoleForm(),
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => InfoScreen(),
      ),
    );
  }
}
