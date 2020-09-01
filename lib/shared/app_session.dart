
import 'package:food_booking/models/user_model.dart';

class AppSession {
  /// Singleton instance
  static final AppSession instance = AppSession._internal();
  AppSession._internal();

  /// true if network call return error
  bool isNetworkError;

  /// This widget is use to access to main page ==> HomePageState
  dynamic mainWidget;
  String userName;


  /// Set session information
  void setSession({String userName}) {
    if(userName != null) this.userName = userName;
  }

  /// Set Main Widget
  void setMainContext(dynamic mainWidget)
  {
    if(mainWidget != null) this.mainWidget = mainWidget;
  }

  /// Refresh user statistic
  void refreshAppStatistic() async
  {
    if(this.mainWidget != null)
    {
      Future.delayed(Duration(milliseconds: 500), () {
        try{
          this.mainWidget.loadStatistic();
        }
        on Exception {
          return;
        }
        catch(e) {
          return;
        }
      });
    }
  }
}
