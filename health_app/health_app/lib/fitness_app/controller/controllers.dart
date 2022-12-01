import 'package:get/get.dart';
import 'package:health_app/fitness_app/provider/provider.dart';

class DataController extends GetxController with StateMixin<dynamic> {
  @override
  void onInit() {
    super.onInit();
    Provider().getMeals().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
