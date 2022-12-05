import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:health_app/main.dart';
import 'package:health_app/views/components/restext.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math' as math;

class BodyMeasurementView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const BodyMeasurementView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<BodyMeasurementView> createState() => _BodyMeasurementViewState();
}

class _BodyMeasurementViewState extends State<BodyMeasurementView> {
  @override
  final _ageCon = new TextEditingController();
  final _weightCon = new TextEditingController();
  final _heightCon = new TextEditingController();
  final _datas = GetStorage();

  double _currentIntValue = 10;
  double _currentHieghtValue = 80;
  double _currentWieightValue = 40;
  double _currentBMIValue = 10;
  double _hieght = 0.0;
  double _wieght = 0.0;
  double _bmiresult = 0.0;
  String _bmiRes = '';
  double _bodyfat = 0.0;
  String bmiRes = '';
  String iicon = '';
  String _age = '';
  String _gender = 'Male';

  bool _visible = false;
  bool _vinormal = false;
  bool _vioverwieght = false;
  bool _viunderwieght = false;
  bool _viobese = false;
  bool _viexisive = false;

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 223, 223, 231),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(68.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    'Age :',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.darkText),
                                  ),
                                ),
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _ageCon,
                                      validator: (text) {
                                        if (!text!.isNotEmpty) {
                                          return "Field is empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors
                                                  .greenAccent), //<-- SEE HERE
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ],
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    'Gender :',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.darkText),
                                  ),
                                ),
                                Column(
                                  children: [
                                    RadioListTile(
                                      title: Text("Male"),
                                      value: "Male",
                                      groupValue: _gender,
                                      onChanged: (value) {
                                        setState(() {
                                          _gender = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text("Female"),
                                      value: "Female",
                                      groupValue: _gender,
                                      onChanged: (value) {
                                        setState(() {
                                          _gender = value.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    'Weight (Kilogram)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.darkText),
                                  ),
                                ),
                                // Weight
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _weightCon,
                                      validator: (text) {
                                        if (!text!.isNotEmpty) {
                                          return "Field is empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors
                                                  .greenAccent), //<-- SEE HERE
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    'Height (centimeters)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.darkText),
                                  ),
                                ),
                                // Hieght
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _heightCon,
                                      validator: (text) {
                                        if (!text!.isNotEmpty) {
                                          return "Field is empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors
                                                  .greenAccent), //<-- SEE HERE
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 84, 184, 223),
                                            ),
                                            onPressed: () {
                                              if (_heightCon.text.length == 0 &&
                                                  _weightCon.text.length == 0) {
                                                AlertDialog(
                                                  title: const Text(
                                                      "Please Fillup the required fields"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Container(
                                                        color: Colors.green,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child:
                                                            const Text("okay"),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                setState(() {
                                                  _hieght = double.parse(
                                                      _heightCon.text);
                                                  _wieght = double.parse(
                                                      _weightCon.text);

                                                  double aa =
                                                      (_hieght * _hieght) /
                                                          _wieght /
                                                          10000;
                                                  print(_hieght);
                                                  double _bmi = (_wieght /
                                                          _hieght /
                                                          _hieght) *
                                                      10000 as double;

                                                  print(_bmi);

                                                  // math.
                                                  _visible = true;
                                                  _bmiRes =
                                                      _bmi.toStringAsFixed(2);

                                                  if (_bmi < 18.4) {
                                                    bmiRes = 'Underweight';
                                                    _bmiresult = _bmi;
                                                    _viunderwieght = true;
                                                  } else if (_bmi >= 18.5 &&
                                                      _bmi < 25) {
                                                    _bmiresult = _bmi;
                                                    bmiRes = 'Normal';
                                                    _vinormal = true;
                                                  } else if (_bmi > 25 &&
                                                      _bmi < 30) {
                                                    _bmiresult = _bmi;
                                                    bmiRes = 'Overweight';
                                                    _vioverwieght = true;
                                                  } else if (_bmi > 30 &&
                                                      _bmi < 35) {
                                                    _bmiresult = _bmi;
                                                    bmiRes = 'Obese';
                                                    _viobese = true;
                                                  } else if (_bmi > 35) {
                                                    _bmiresult = _bmi;
                                                    bmiRes = 'Extremely Obese';
                                                    _viexisive = true;
                                                  }
                                                });
                                              }
                                              FocusScope.of(context).unfocus();
                                              _datas.write(
                                                "bmiresult",
                                                bmiRes,
                                              );
                                              _datas.write(
                                                  "bmiscore",
                                                  _bmiresult
                                                      .toStringAsFixed(2));
                                              _datas.write(
                                                  "currenthieght",
                                                  _currentHieghtValue
                                                      .toString());
                                              _datas.write(
                                                  "currentwieght",
                                                  _currentWieightValue
                                                      .toString());
                                              _datas.write("currentage",
                                                  _ageCon.text.toString());
                                              _datas.write(
                                                  "currentgender", _gender);
                                            },
                                            child: const Text(
                                              'Calculate',
                                              style: TextStyle(fontSize: 30),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visible,
                    child: resutl(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget resutl() {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        int animation = 0;
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 223, 231),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, bottom: 8, top: 16),
                              child: Text(
                                'Result!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    letterSpacing: -0.1,
                                    color: Color.fromARGB(255, 19, 6, 196)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 280,
                          child: SfRadialGauge(axes: <RadialAxis>[
                            RadialAxis(
                              interval: 5,
                              maximum: 45,
                              showTicks: false,
                              canScaleToFit: true,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                  startValue: 0,
                                  endValue: 18.5,
                                  color: Color.fromARGB(255, 233, 122, 159),
                                ),
                                GaugeRange(
                                  startValue: 18.5,
                                  endValue: 25,
                                  color: Colors.green,
                                ),
                                GaugeRange(
                                  startValue: 25,
                                  endValue: 30,
                                  color: Colors.yellowAccent,
                                ),
                                GaugeRange(
                                  startValue: 30,
                                  endValue: 45,
                                  color: Colors.redAccent,
                                )
                              ],
                              axisLineStyle: AxisLineStyle(
                                thickness: 15,
                              ),
                              pointers: <GaugePointer>[
                                MarkerPointer(
                                    value: _bmiresult,
                                    markerWidth: 20,
                                    markerHeight: 25,
                                    markerOffset: -20,
                                    enableAnimation: true,
                                    color: Colors.indigo)
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.05,
                                    widget: Text(
                                      '$bmiRes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )),
                                GaugeAnnotation(
                                    positionFactor: 0.70,
                                    angle: 90,
                                    widget: Text(
                                      'BMI Score',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                                GaugeAnnotation(
                                    positionFactor: .90,
                                    angle: 90,
                                    widget: Text(
                                      '[ ' +
                                          _bmiresult.toStringAsFixed(2) +
                                          ' ]',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ))
                              ],
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 8),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.background,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '$_currentHieghtValue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: FitnessAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Height',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '$_currentWieightValue',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FitnessAppTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            'Weight',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          _ageCon.text.toString(),
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FitnessAppTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            'Age',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '$_gender',
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FitnessAppTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            'Gender',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 84, 184, 223),
                              ),
                              onPressed: () {
                                setState(() {});
                                Get.toNamed("/recone");
                              },
                              child: const Text(
                                'Show Recommendation',
                                style: TextStyle(fontSize: 24),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}

void ResultsX(int resx) {
  if (resx == 1) {
    ResText(iColor: Colors.red, iText: "No");
  } else {
    ResText(iColor: Colors.green, iText: "Yes");
  }
}
