import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/logo.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/utils/common.dart';



class SuccessPage extends StatefulWidget {
  final String title;
  final String content;
  final String logo;
  final String titleButton;
  final Function onPress;
  final int isPopProfile;

  SuccessPage({this.title,this.content,this.logo,this.titleButton,this.onPress,this.isPopProfile = 0});
  @override
  SuccessPageState createState() => SuccessPageState();
}
class SuccessPageState extends State<SuccessPage> {

  TextEditingController controllerPhone = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    Common.hideSoftKeyboard(context);

    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: BookingAppBar.getAppBar(
                title: widget.title,
                showBackButton: false
            ),
            body: Material(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (widget.logo == null
                          ? Icon(Icons.check_circle_outline, size: 120, color: AppColors.colorSnackBarSuccess,)
                          : SharedLogo.logo(paddingTop: 1, paddingBottom: 60,logoName: widget.logo)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          widget.content == null ? "" : widget.content,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding (
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: NormalButton(
                                title: widget.titleButton == null ? 'Trở lại' : widget.titleButton,
                                onPress: () {
                                  if(widget.onPress == null){
                                    if(widget.isPopProfile > 0){
                                      int count = 0;
                                      Navigator.of(context).popUntil((_) => count++ >= widget.isPopProfile);
                                    }else{
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                    }

                                    return;
                                  }
                                  widget.onPress();
                                })
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onWillPop: () {
        return Future(() => false);
      },
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}

