import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_booking/shared/app_colors.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final double height;
  final List<Widget> leadings;
  final List<Widget> actions;

  CustomAppBar(
      this.title, {
        this.leadings = const [],
        this.actions = const [],
        this.height = 120,
      });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 25,
                    top: 5,
                    bottom: 5,
                    child: Row(
                      children: leadings,
                    ),
                  ),
                  Center(
                    child: Text(
                      this.title,
                      style: TextStyle(
                        color: AppColors.DARK,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    top: 5,
                    bottom: 5,
                    child: Row(
                      children: actions,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarAction extends StatelessWidget {
  final Function action;
  final IconData icon;
  final int quantity;

  CustomAppBarAction(this.action, this.icon, {this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 50,
        height: 50,
        child: FlatButton(
          onPressed: action,
          padding: EdgeInsets.zero,
          color: AppColors.WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Icon(
                icon,
                size: 21,
                color: AppColors.GREEN,
              ),
              Visibility(
                visible: quantity != null,
                child: Positioned(
                  top: -5,
                  right: -10,
                  child: Container(
                    width: 15,
                    height: 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.DARK,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      quantity.toString() ?? "",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.WHITE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
