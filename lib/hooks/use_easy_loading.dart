import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EasyLoadingController {
  void show({String? status, EasyLoadingMaskType? maskType}) {
    EasyLoading.show(
      status: status,
      maskType: maskType ?? EasyLoadingMaskType.black,
    );
  }

  void dismiss() {
    EasyLoading.dismiss();
  }

  void showSuccess(String message, {EasyLoadingMaskType? maskType}) {
    EasyLoading.showSuccess(
      message,
      maskType: maskType ?? EasyLoadingMaskType.black,
    );
  }

  void showError(String message, {EasyLoadingMaskType? maskType}) {
    EasyLoading.showError(
      message,
      maskType: maskType ?? EasyLoadingMaskType.black,
    );
  }
}

EasyLoadingController useEasyLoading() {
  return useMemoized(() => EasyLoadingController(), []);
}