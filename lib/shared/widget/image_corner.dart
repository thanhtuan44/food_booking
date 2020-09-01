import 'package:flutter/material.dart';
import 'package:food_booking/utils/assets_link.dart';


class ImageCorner extends StatelessWidget {
  final double radius;
  final double height;
  final double width;
  final String image;
  ImageCorner({this.width,this.height,this.image,this.radius});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius == null? 5.0 : radius),
      child: image != null ?
      Image.network(
        image,
        height: height == null ? 44.0 : height,
        width: width == null ? 44.0 : width,
        fit: BoxFit.fill,
      ):
      Image.asset(
        assetsLink + "logo.png",
        height: height == null ? 44.0 : height,
        width: width == null ? 44.0 : width,
        fit: BoxFit.fill,
      ),
    );
  }
}

