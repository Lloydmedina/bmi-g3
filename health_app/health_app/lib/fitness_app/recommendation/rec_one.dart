import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/fitness_app/controller/controllers.dart';
import 'package:health_app/fitness_app/models/meal_model.dart';
import 'package:flutter/services.dart' as bundle;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RecOne extends GetView<DataController> {
  RxString addthis = ''.obs;
  DataController controller = new DataController();
  List respo = [];
  final filter = '';
  @override
  void initState() {
    respo = ReadJsonData() as List;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recommendations'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                infos(),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<MealModel>;
                      _data.write("recomendation", data.toString());
                      // var filter = _data.read("bmiresult");
                      return Column(
                        children: [
                          Text("Recommended Meals"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  items[index].name.toString() +
                                                      " : "),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(items[index]
                                                        .meal1
                                                        .toString()),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(items[index]
                                                        .meal2
                                                        .toString()),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(items[index].meal3 ==
                                                            null
                                                        ? " "
                                                        : items[index]
                                                            .meal3
                                                            .toString()),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Recommended Water Consumption"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  items[index].name.toString() +
                                                      " : "),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(items[index]
                                                        .water
                                                        .toString()),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Recommended Training "),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(items[index].training == null
                                                  ? " "
                                                  : items[index]
                                                      .training
                                                      .toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setApointment();

                                Get.back();
                              },
                              child: Text("Save Recommendation?")),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
              ],
            ),
          ),
        ));
  }
}

final _data = GetStorage();

Widget infos() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: SizedBox(
              width: 320,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  /// Add this
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Age : " + _data.read("currentage")),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Gender : " + _data.read("currentgender")),
                    SizedBox(
                      height: 3,
                    ),
                    Text("BMI Result : " + _data.read("bmiresult")),
                    SizedBox(
                      height: 3,
                    ),
                    Text("BMI Score : " + _data.read("bmiscore")),
                  ],
                ),
              )),
        ),
      ),
    ],
  );
}

Future<List<MealModel>> ReadJsonData() async {
  //read json file

  var url = '';
  var filter = _data.read("bmiresult");
  if (filter == 'Underweight') {
    url = 'jsonFiles/meal1.json';
    _data.write("urlFor", url);
  } else if (filter == 'Normal') {
    url = 'jsonFiles/meal2.json';
    _data.write("urlFor", url);
  } else if (filter == 'Overweight') {
    url = 'jsonFiles/meal3.json';
    _data.write("urlFor", url);
  } else if (filter == 'Obese') {
    url = 'jsonFiles/meal4.json';
    _data.write("urlFor", url);
  } else if (filter == 'Extremely Obese') {
    url = 'jsonFiles/meal5.json';
    _data.write("urlFor", url);
  }
  final data = await bundle.rootBundle.loadString(url);
  //decode json data as list
  final list = json.decode(data) as List<dynamic>;

  //map json and initialize using DataModel

  var aaaa1 = list[0].toString();
  var aaaa2 = list[1].toString();
  var aaaa3 = list[2].toString();
  var trim1 = aaaa1.substring(aaaa1.indexOf('Breakfast'), aaaa1.indexOf('}'));
  // var trim2 = aaaa2.substring(aaaa2.indexOf('Breakfast'), aaaa2.indexOf('}'));
  // var trim3 = aaaa3.substring(aaaa3.indexOf('Breakfast'), aaaa3.indexOf('}'));

  //_data.write('recom1', aaaa1);
  _data.write('recom2', aaaa2);
  _data.write('recom3', aaaa3);
  _data.write('recom1', trim1);
  // _data.write('recom2', trim2);
  // _data.write('recom3', trim3);

  print(aaaa1.substring(aaaa1.indexOf('Breakfast'), aaaa1.indexOf('}')));
  return list.map((e) => MealModel.fromJson(e)).toList();
}

List<Appointment> setApointment() {
  List<Appointment> scheduled = <Appointment>[];
  final DateTime starttime = new DateTime.now();
  final DateTime endtime = starttime.add(const Duration(hours: 48));
  var body = "bmi_result :" +
      _data.read('bmiresult') +
      ",\nbmi_score : " +
      _data.read("bmiscore") +
      ",\nage : " +
      _data.read("currentage") +
      ",\ngender : " +
      _data.read("currentgender") +
      "\nRecomendation : \n" +
      "Morning :" +
      "" +
      _data.read("recom1") +
      "\n Noon :" +
      _data.read("recom2") +
      "\n Evening :" +
      _data.read("recom3") +
      "";
  scheduled.add(Appointment(
    startTime: starttime,
    endTime: endtime,
    subject: body,
    isAllDay: true,
  ));
  return scheduled;
}

class AgendaDataSource extends CalendarDataSource {
  AgendaDataSource(List<Appointment> source) {
    appointments = source;
  }
}
