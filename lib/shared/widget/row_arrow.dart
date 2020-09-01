import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/utils/assets_link.dart';

class RowArrow extends StatelessWidget {
  final BuildContext context;
  final String title;
  final VoidCallback onPress;
  final String imageUrl;
  final bool isDeleteUnderline;

  RowArrow({this.context,this.title, this.onPress,this.imageUrl,this.isDeleteUnderline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          child: Column(
            children: <Widget>[
              Container(
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container (
                      child:  Row(
                        children: <Widget>[
                          Container(width: 64,
                              child: Container(
                                  child: IconButton(
                                    icon: Image.asset(assetsLink + imageUrl, height: 44,),
                                  )
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Center(
                                child: Text(title == null ? "" : title),
                              ),
                              Container(
                                  child: IconButton(
                                    icon: Image.asset(assetsLink + 'icon_next.png', height: 20,),
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              isDeleteUnderline ? Container(width: 0,height: 0,) :
              Padding(
                padding: const EdgeInsets.only(left: 64,right: 20),
                child: Divider(color: AppColors.colorListSeparate, height: 1,),
              ),
            ],
          ),
          onTap: (){
            onPress();
          },
        )
    );
  }
}

