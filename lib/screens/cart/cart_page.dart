import 'package:flutter/material.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/utils/assets_link.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  int shoppingCartCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookingAppBar.getAppBar(
        title: "CART",
        showBackButton: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildShoppingCartItem(context),
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                height: 120,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Subtotal"),
                            Text("\$278.78"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Shipping cost"),
                            Text(
                              "\$20.00",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("\$308.78"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: NormalButton(
                    title: 'Mua Hàng',
                    onPress: () {

                    },
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildShoppingCartItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      height: 220,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width) / 3,
              child: Column(
                children: <Widget>[
                  Image.asset(assetsLink + 'bag_1.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              shoppingCartCount--;
                            });
                          },
                        ),
                        Text(
                          '$shoppingCartCount',
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              shoppingCartCount++;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 37) / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 12.0),
                        width: 150,
                        child: Text(
                          "Philips 42FYHFH45 81 Cm FullHD",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "\$ 2.500",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Show Details",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
