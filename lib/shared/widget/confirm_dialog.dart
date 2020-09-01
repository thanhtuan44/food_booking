import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:food_booking/utils/value_util.dart';



class ConfirmDialog extends StatelessWidget {
  final String title, description;
  final bool isSingleButton;
  final String cancelButton;
  final String doneButton;
  final Image image;
  final Function confirmAction;
  final Function cancelAction;

  ConfirmDialog({
    this.title,
    this.isSingleButton = false,
    @required this.description,
    this.confirmAction,
    this.image,
    this.cancelButton,
    this.doneButton,
    this.cancelAction
  });


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius - Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: 40),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title != null ?
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ): Container(width: 0, height: 0,),
              SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.SIZE_TEXT_LIST_TITLE,
                ),
              ),
              SizedBox(height: 8.0),
              isSingleButton?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if(cancelAction != null) cancelAction();
                    },
                    child: Text(cancelButton ?? "Không", textAlign: TextAlign.center),
                  ),
                ],
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if(cancelAction != null) cancelAction();
                      },
                      child: Text(cancelButton ?? "Không", textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(child:
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if(confirmAction != null) confirmAction();
                    },
                    child: Text(doneButton ?? "Đồng ý", textAlign: TextAlign.center,),
                  ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          top: Consts.padding ,
          child: Container(
              width: Consts.avatarRadius,
              height: Consts.avatarRadius,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.contain,
                    image: new AssetImage(assetsLink + 'logo.png'),
                  )
              )),
        ),
      ],

    );

  }
}
