import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_booking/screens/nearby/controller.dart';
import 'package:food_booking/screens/nearby/list_categories.dart';
import 'package:food_booking/screens/nearby/list_products.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/widget/custom_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
//          appBar: CustomAppBar(
//            "GetX Concepts",
//            actions: [
//              Obx(
//                    () => CustomAppBarAction(
//                      () => {},
//                  Feather.shopping_cart,
//                  quantity: controller.cartQuantity,
//                ),
//              ),
//            ],
//          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListCategories(),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 25,
                ),
                sliver: SliverToBoxAdapter(child: Container(height: 100,),),
//               sliver: HomeList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
class NearByPage extends StatefulWidget {
  @override
  _NearByPageState createState() => _NearByPageState();
}

class _NearByPageState extends State<NearByPage> {
  static LocationData currentLocation;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(currentLocation == null ? 10.77628 : currentLocation.latitude,
                    currentLocation == null ? 106.70097 : currentLocation.longitude),
    zoom: 14.4746,
  );

  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  _getLocation() async {
    var location = new Location();
    try {
      LocationData currentLocationTemp = await location.getLocation();

      print("locationLatitude: ${currentLocationTemp.latitude}");
      print("locationLongitude: ${currentLocationTemp.longitude}");
      setState(
              () {
//                currentLocation = currentLocationTemp;
              }); //rebuild the widget after getting the current location of the user
    } on Exception {
      currentLocation = null;
    }
  }

  @override
  void initState(){
    _getLocation();
     super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

