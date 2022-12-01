import 'package:get/instance_manager.dart';
import 'package:health_app/fitness_app/controller/controllers.dart';

class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataController());
  }
}
