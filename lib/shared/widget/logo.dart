import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/utils/assets_link.dart';

class SharedLogo {
  static Widget logo({
    String logoName,
    bool isLeft = false,
    double paddingTop = 40,
    double paddingBottom = 100,
    double logoHeight = 100,
    double logoWidth = 100,
    double logoRadius = 48
  })
  {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Container(
        height: logoHeight,
        width: logoWidth,
        child: new Hero(
          tag: 'logoTag',
          child: isLeft
              ?  Container(
              child: FittedBox(
                child: Image.asset(assetsLink + 'logo_slogen.png'),
                fit: BoxFit.fill,
              ))
              : CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: logoRadius,
            child: Image.asset( assetsLink + (logoName == null ? 'logo.png' : logoName)),
          ),
        ),
      ),
    );
  }
}
