import 'dart:ui';
import 'package:protour_traval/vole_ticket/vole_list_view.dart';
import 'package:protour_traval/vole_ticket/model/ticket_list_data.dart';
import 'package:flutter/material.dart';
import 'package:protour_traval/app_theme.dart';
import 'vole_search.dart';

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
                                callback: () {},
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
/*
  Widget getSearchBarUI() {
    return Form(
      child: Container(
        color: AppTheme.grey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: DropdownButton<String>(
                            value: dropdownValue_1,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_1 = newValue;
                              });
                            },
                            items: <String>[
                              'One way',
                              'Round trip',
                              'Multi city',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 90,
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: AppTheme.grey,
                            ),
                            hintText: '1',
                            alignLabelWithHint: false,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppTheme.grey,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: DropdownButton<String>(
                            value: dropdownValue_2,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_2 = newValue;
                              });
                            },
                            items: <String>[
                              'Economic',
                              'Bussnice',
                              'Bussnice',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: DropdownButton<String>(
                            value: dropdownValue_3,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_3 = newValue;
                              });
                            },
                            items: <String>[
                              'Algeria',
                              'France',
                              'Italy',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(90.0))),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.compare_arrows_sharp,
                              color: AppTheme.black,
                              size: 30,
                            ),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: DropdownButton<String>(
                            value: dropdownValue_3,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_3 = newValue;
                              });
                            },
                            items: <String>[
                              'Algeria',
                              'France',
                              'Italy',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: DropdownButton<String>(
                            value: dropdownValue_4,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_4 = newValue;
                              });
                            },
                            items: <String>[
                              '15-Jan-2020',
                              '15-Jan-2021',
                              '22-Feb-2021',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: DropdownButton<String>(
                            value: dropdownValue_4,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.unfold_more,
                                color: AppTheme.grey,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.grey,
                            ),
                            underline: Container(
                              height: 0,
                              //color: Colors.black38,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue_4 = newValue;
                              });
                            },
                            items: <String>[
                              '15-Jan-2020',
                              '15-Jan-2021',
                              '22-Feb-2021',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                            }
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  */

  Widget getSearchBarUI() {
    return Container(
      color: AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SearchVoleForm(),
      ),
    );
  }
}
