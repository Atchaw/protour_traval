//import 'package:protour_traval/hotel_booking/hotel_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:protour_traval/app_theme.dart';

import 'model/ticket_list_data.dart';

class TicketListView extends StatelessWidget {
  const TicketListView(
      {Key key,
      this.ticketData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final TicketListData ticketData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          height: 80,
                          child: Center(
                            child: Image.asset(
                              ticketData.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Row(
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    ticketData.timeDept,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  Text(
                                                    ticketData.airportDep,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.arrow_right_alt,
                                                size: 30,
                                                color:
                                                    AppTheme.nearlyDarkYellow,
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    ticketData.timeArr,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  Text(
                                                    ticketData.airportArr,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '\$${ticketData.prix}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            ticketData.voleStop,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                ticketData.timeTrip + 'hr',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.clock,
                                                //Icons.timer,
                                                size: 12,
                                                color:
                                                    AppTheme.nearlyDarkYellow,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            ticketData.voleType,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
