import 'dart:convert';

import 'package:flutter/services.dart' as bundle;
import 'package:health_app/fitness_app/models/meal_model.dart';

class Provider {
  Future<List<MealModel>> getMeals() async {
    final getfile = await bundle.rootBundle.loadString('jsonFiles/meals.json');
    final List = json.decode(getfile);

    return List.map((e) => MealModel.fromJson(e)).toList();
  }
}
