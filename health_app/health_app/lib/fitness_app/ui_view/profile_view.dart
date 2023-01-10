import 'package:health_app/fitness_app/recommendation/rec_one.dart';
import 'package:health_app/main.dart';
import 'package:flutter/material.dart';
import '../fitness_app_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProfileView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 1, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 215, 216, 231),
                        HexColor("#6F56E8")
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.6),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Daily',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.nearlyWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: FitnessAppTheme.nearlyBlack
                                              .withOpacity(0.4),
                                          offset: Offset(8.0, 8.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // here
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1000,
                  color: Colors.white,
                  child: SfCalendar(
                    dataSource: AgendaDataSource(setApointment()),
                    showNavigationArrow: true,
                    view: CalendarView.month,
                    initialDisplayDate: DateTime.now(),
                    monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        agendaStyle: AgendaStyle(
                            backgroundColor: Colors.transparent,
                            appointmentTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            )),
                        agendaViewHeight: 650,
                        agendaItemHeight: 650),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
