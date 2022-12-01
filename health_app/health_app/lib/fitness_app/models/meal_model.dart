import 'dart:convert';

List<MealModel> mealModelFromJson(String str) =>
    List<MealModel>.from(json.decode(str).map((x) => MealModel.fromJson(x)));

String mealModelToJson(List<MealModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealModel {
  MealModel(
      {required this.id,
      required this.category,
      required this.name,
      required this.water,
      required this.meal1,
      required this.meal2,
      required this.meal3,
      required this.training});

  int? id;
  int? category;
  String? name;
  String? water;
  String? meal1;
  String? meal2;
  String? meal3;
  String? training;

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
      id: json["id"],
      category: json["category"],
      name: json["name"],
      water: json["water"],
      meal1: json["meal1"],
      meal2: json["meal2"],
      meal3: json["meal3"],
      training: json['training']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "water": water,
        "meal1": meal1,
        "meal2": meal2,
        "meal3": meal3,
        "training": training
      };
}
