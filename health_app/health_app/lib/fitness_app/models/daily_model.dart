class DailyModel {
  final int? id;
  final DateTime? date;
  final double? bmi_result;
  final int? run_time;
  final int? jump_time;
  final int? push_time;
  final int? sit_time;
  final String? completed;

  DailyModel(
      {this.id,
      this.date,
      this.bmi_result,
      this.run_time,
      this.jump_time,
      this.push_time,
      this.sit_time,
      this.completed});
  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
      id: json['id'],
      date: json['date'],
      bmi_result: json['bmi_result'],
      run_time: json['run_time'],
      jump_time: json['jump_time'],
      push_time: json['push_time'],
      sit_time: json['sit_time'],
      completed: json['completed']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'bmi_result': bmi_result,
        'run_time': run_time,
        'jump_time': jump_time,
        'push_time': push_time,
        'sit_time': sit_time,
        'completed': completed
      };
}
