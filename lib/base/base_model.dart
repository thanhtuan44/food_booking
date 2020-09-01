import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  bool isShowLoading = false;
  showLoading(bool loading) {
    isShowLoading = loading;
    update();
  }
  update() {
    notifyListeners();
  }
  @override
  void dispose() {
    super.dispose();
  }
}