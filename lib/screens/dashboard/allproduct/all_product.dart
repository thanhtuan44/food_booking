import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/models/product.dart';
import 'package:food_booking/screens/dashboard/categorries.dart';
import 'package:food_booking/screens/dashboard/dashboard_page.dart';
import 'package:food_booking/screens/dashboard/item_card.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/scale_animation.dart';
import 'package:food_booking/utils/consts.dart';


class AllProductPage  extends StatefulWidget {
  @override
  AllProductPage_State createState() => AllProductPage_State();
}

class AllProductPage_State extends State<AllProductPage> {
  var isShowLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BookingAppBar.getAppBar(
          title: "All Product",
          showBackButton: true,
        ),
    backgroundColor: Colors.white,
    body: Column(
        children: [
          Categories(onPress: ()=>{
            update()
          },),
          isShowLoading ?
            Container(
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
          ) : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    product: products[index],
                  )),
            ),
          )
        ],
      ),
    );
  }
  void update(){
    setState(() {
      isShowLoading = true;
    });
    Future.delayed(Duration(milliseconds: 500), () async {
      setState(() {
        isShowLoading = false;
      });
    });

  }
}
