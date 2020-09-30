import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_booking/models/product.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class ProductDetailPage extends StatefulWidget {
  final Product product = Product(
      title: 'Apple',
      description: 'iPhone 7 plus (128GB)',
      image: 'assets/images/topmenu/ic_burger.png',
      price: 2000);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 11,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    child: Divider(
                      color: Colors.black26,
                      height: 4,
                    ),
                    height: 24,
                  ),
                  Text(
                    "\$ 5.674",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "\$ 3.800",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                width: 6,
              ),
              RaisedButton(
                onPressed: () {
                  _alert(context);
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.9,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        MaterialCommunityIcons.getIconData(
                          "cart-outline",
                        ),
                        color: Colors.white,
                      ),
                      new Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                Stack(
                  children: <Widget>[
                    isClicked
                        ? Positioned(
                      left: 9,
                      bottom: 13,
                      child: Icon(
                        Icons.looks_one,
                        size: 14,
                        color: Colors.red,
                      ),
                    )
                        : Text(""),
                  ],
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height / 2.4,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  this.widget.product.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                background: Padding(
                  padding: EdgeInsets.only(top: 48.0),
                  child: dottedSlider(),
                ),
              ),
            ),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildInfo(context), //Product Info
                _buildExtra(context),
                _buildDescription(context),
                _buildComments(context),
                _buildProducts(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Shopping Cart",
      desc: "Your product has been added to cart.",
      buttons: [
        DialogButton(
          child: Text(
            "BACK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GO CART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
//              child: ShoppingCart(true),
            ),
          ),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  _productSlideImage(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image:
        DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.contain),
      ),
    );
  }

  dottedSlider() {
    return DottedSlider(
      maxHeight: 200,
      children: <Widget>[
        _productSlideImage(widget.product.image),
        _productSlideImage(widget.product.image),
        _productSlideImage(widget.product.image),
        _productSlideImage(widget.product.image),
      ],
    );
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(width: 130, child: Text("Front Camera")),
                SizedBox(
                  width: 48,
                ),
                Text("16 MP"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(width: 130, child: Text("Internal Storage")),
                SizedBox(
                  width: 48,
                ),
                Text("128 GB"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Tüm Özellikler >",
                style: TextStyle(color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildExtra(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.black12),
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          )),
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Capacity"),
            Row(
              children: <Widget>[
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('64 GB'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('128 GB'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.red, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1, //width of the border
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("Color"),
            Row(
              children: <Widget>[
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('GOLD'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.orangeAccent, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1.5, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('SILVER'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('PINK'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."),
            SizedBox(
              height: 8,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context);
                },
                child: Text(
                  "View More",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildComments(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarRating(rating: 4, size: 20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "1250 Comments",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
              ),
              subtitle: Text(
                  "Cats are good pets, for they are clean and are not noisy."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "12 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.familiadejesusperu.org/images/avatar/john-doe-13.jpg"),
              ),
              subtitle: Text(
                  "There was no ice cream in the freezer, nor did they have money to go to the store."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "15 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1020903668240052225/_6uVaH4c.jpg"),
              ),
              subtitle: Text(
                  "I think I will buy the red car, or I will lease the blue one."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "25 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Similar Items",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTrending()
      ],
    );
  }

  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              TrendingItem(
                product: Product(
                    title: 'Apple',
                    description: 'iPhone 7 plus (128GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Apple',
                    description: 'iPhone 11 (128GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'iPhone',
                    description: 'iPhone 11 (64GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Xiaomi',
                    description: 'Xiaomi Redmi Note8',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Apple',
                    description: 'iPhone 11 (128GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'iPhone',
                    description: 'iPhone 11 (64GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Xiaomi',
                    description: 'Xiaomi Redmi Note8',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Apple',
                    description: 'iPhone 11 (128GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'iPhone',
                    description: 'iPhone 11 (64GB)',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              ),
              TrendingItem(
                product: Product(
                    title: 'Xiaomi',
                    description: 'Xiaomi Redmi Note8',
                    image: 'assets/images/topmenu/ic_burger.png',
                    price: 2000),
                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              ),
            ],
          ),
        )
      ],
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      });
}


class DottedSlider extends StatefulWidget {
  final Color color;
  final List<Widget> children;
  final double maxHeight;
  DottedSlider({Key key, this.color, this.children, this.maxHeight})
      : super(key: key);

  @override
  _DottedSliderState createState() => new _DottedSliderState();
}

class _DottedSliderState extends State<DottedSlider> {
  PageController controller = PageController();

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: PageView(
            controller: controller,
            children: widget.children,
          ),
        ),
        _drawDots(currentPage)
      ],
    );
  }

  _drawDots(page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < widget.children.length; i++) dot((page == i)),
      ],
    );
  }

  dot(bool selected) {
    double size = 6;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 2, left: 2, bottom: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selected) ? widget.color : Colors.black38),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  StarRating({this.rating, this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: new List.generate(5, (index) => _buildStar(index, rating)));
  }

  _buildStar(int index, double rating) {
    IconData icon;
    Color color;
    if (index >= rating) {
      icon = Icons.star;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Colors.yellow;
    } else {
      icon = Icons.star;
      color = Colors.yellow;
    }
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}

class TrendingItem extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  TrendingItem({this.product, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = 140;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: trendCardWidth,
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Ionicons.getIconData("ios-heart-empty"),
                          color: Colors.black54,
                        )
                      ],
                    ),
                    _productImage(),
                    _productDetails()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(),
          ),
        );
      },
    );
  }

  _productImage() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(product.image), fit: BoxFit.contain),
            ),
          ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.title,
          style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        ),
        Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        StarRating(rating: 4, size: 10),
        Row(
          children: <Widget>[
            Text(int.parse(product.price.toString()).toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            Text(
              '#00.000',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  decoration: TextDecoration.lineThrough),
            )
          ],
        )
      ],
    );
  }
}
