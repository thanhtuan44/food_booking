import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'scale_animation.dart';


class LoadingView {
  static Widget widget({
    bool loading,
  })
  {
    return Container(
      child: loading ?
      Container(
        color: Colors.black12,
        child: Center(
            child: ScaleAnimation(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: SpinKitFadingCircle(
                      color: AppColors.colorTitle,
                      size: 64,
                    ),
                  ),
                ],
              ),
            )
        ),
      ) : Container(width: 0, height: 0,),
    );
  }
}