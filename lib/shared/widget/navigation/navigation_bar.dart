import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/utils/assets_link.dart';


import 'navigation_bar_item.dart';

// ignore: must_be_immutable
class TitledBottomNavigationBar extends StatefulWidget {
  final Curve curve;
  final Color activeColor;
  final Color inactiveColor;
  final Color inactiveStripColor;
  final Color indicatorColor;
  int currentIndex;
  bool isHighlight;
  final ValueChanged<int> onTap;
  final List<TitledNavigationBarItem> items;

  TitledBottomNavigationBar({
    Key key,
    this.curve = Curves.linear,
    @required this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor,
    this.inactiveStripColor,
    this.indicatorColor,
    this.currentIndex = 0,
    this.isHighlight = false,
  })  : assert(items != null),
        assert(items.length >= 2 && items.length <= 5),
        assert(onTap != null),
        assert(currentIndex != null),
        super(key: key);

  @override
  State createState() => _TitledBottomNavigationBarState();
}

class _TitledBottomNavigationBarState extends State<TitledBottomNavigationBar> {
  static const double BAR_HEIGHT = AppSizes.SIZE_TAB_BAR_HEIGHT;
  static const double INDICATOR_HEIGHT = 3;


  Curve get curve => widget.curve;

  List<TitledNavigationBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Color inactiveColor;
  Duration duration = Duration(milliseconds: 270);

  double _getIndicatorPosition(int index) =>
      (-1 + (2 / (items.length - 1) * index));

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ?? AppColors.colorLabel;
    inactiveColor = widget.inactiveColor ?? AppColors.colorTextFieldLabel;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: BAR_HEIGHT,
          width: width,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: INDICATOR_HEIGHT,
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return GestureDetector(
                      onTap: () => _select(index),
                      child:
                      _buildItemWidget(item, index == widget.currentIndex),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 0,
                width: width,
                child: AnimatedAlign(
                  alignment:
                  Alignment(_getIndicatorPosition(widget.currentIndex), 0),
                  curve: curve,
                  duration: duration,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      color: widget.indicatorColor ?? activeColor,
                      alignment: Alignment.center,
                      width: widget.isHighlight ? ((width / items.length) - 30) : 0,
                      height: INDICATOR_HEIGHT,
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

  _select(int index) {
    widget.currentIndex = index;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget _buildIcon(TitledNavigationBarItem item, bool selected) {
    String icon = item.icon;
    if(selected) icon = icon + "_selected";
    if(item.showBadge != null && item.showBadge) {
      String counterString = item.badgeContent.toString();
      if(counterString != "") {
        int numberCount = int.tryParse(counterString);
        if(numberCount != null && numberCount >= 100) {
          counterString = "99+";
        }
      }
      return Badge(
        animationType: BadgeAnimationType.fade,
        animationDuration: Duration(milliseconds: 0),
        showBadge: true,
        badgeContent: Text(counterString, style: new TextStyle(color: Colors.white,fontSize: 9, fontWeight: FontWeight.w500),),
        child: ImageIcon(
          AssetImage(assetsLink + "icons/" + icon + ".png"),
          color: selected ? activeColor : inactiveColor,
        ),
      );
    }
    return ImageIcon(
      AssetImage(assetsLink + "icons/" + icon + ".png"),
      color: selected ? activeColor : inactiveColor,
    );
  }

  Widget _buildText(TitledNavigationBarItem item, bool selected) {
    return Text(
      item.title,
      style: TextStyle(color: selected ? activeColor : inactiveColor,
          fontSize: AppSizes.SIZE_TAB_BAR_TEXT_SIZE, fontWeight: FontWeight.w500
      ),
    );
  }

  Widget _buildItemWidget(TitledNavigationBarItem item, bool isSelected) {
    if(widget.isHighlight == false) {
      isSelected = false;
    }
    return Container(
      color: item.backgroundColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildIcon(item, isSelected),
                Container(height: 5,),
                _buildText(item, isSelected),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
