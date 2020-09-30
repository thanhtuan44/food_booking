import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/data/spref.dart';
import 'package:food_booking/screens/login/login_page.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/app_session.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/shared/widget/confirm_dialog.dart';
import 'package:food_booking/shared/widget/image_corner.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/row_arrow.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:image_picker/image_picker.dart';



class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}
class ProfilePageState extends State<ProfilePage> {

  TextEditingController controllerPhone = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showLoading = false;
  File urlImageProfile;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(height: 60,),
                Stack(
                  children: <Widget>[
//                    InkWell(
//                      child: Container(
//                        height: 100,
//                        width: 64,
//                        child: IconButton(
//                          icon: Image.asset(assetsLink + 'icon_back.png', height: 32,),
//                        ),
//                      ),
//                      onTap: (){Navigator.of(context).pop(this);},
//                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            child: Container(
                              height: 88,width: 88,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  urlImageProfile == null
                                    ? Image.asset(assetsLink + "logo.png")
                                    : Image.file(urlImageProfile, width: 100, height: 100,fit: BoxFit.cover)
                            ),
                            onTap: () {
                              _pickImage(context);
                            }
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: 16,),
                Text("Xin chào",style: TextStyle(color: AppColors.colorTextFieldLabel,fontSize: AppSizes.SIZE_LABEL_SMALL),),
                Text(AppSession.instance.userName == null ? "NONE REGISTER NAME" : AppSession.instance.userName,
                  style: TextStyle(fontSize: AppSizes.SIZE_TEXT_TITLE_BIG, fontWeight: FontWeight.bold),),
//                HeaderProfile(),

                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Container(
                    child: Container(
                      decoration: new BoxDecoration(
                        color: AppColors.colorHeaderProfile,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          RowArrow(context: context,imageUrl: 'icon_profile.png',title:'Cập nhật thông tin',onPress:() {
//                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => UpdateInfoPage()));
                          }),
                          RowArrow(context: context,imageUrl: 'icon_change.png',title:'Sản phẩm yêu thích',onPress:() {
//                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => ChangePassNotifyPage()));
                          }),
//                            RowArrow(context: context,imageUrl: 'icon_profile.png',title:'Nạp tiền',onPress:() {
//                              Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => RechargePage()));
//                            }),
                          RowArrow(context: context,imageUrl: 'icon_time.png',title:'Thông báo',onPress:() {}),
                          RowArrow(context: context,isDeleteUnderline: true,imageUrl: 'icon_change_password.png',title:'Đổi mật khẩu',onPress:() {
//                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => ChangePassPage()));
                          }),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
                    child: Container (
                      child: NormalButton(
                        title: 'Đăng xuất',
                        btnStyle: TextStyle(fontSize: AppSizes.SIZE_TEXT_BUTTON_SMALL, color: Colors.white),
                        onPress: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => ConfirmDialog(
                                  title: 'Đăng xuất',
                                  description:
                                  "Bạn có muốn đăng xuất",
                                  confirmAction: () async {
                                    SPref.instance.set(AppConstants.KEY_STORED_USER, null);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                                          (_)=>false,
                                    );
                                  }
                              ));
                        },
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
        LoadingView.widget(loading: showLoading)
      ],
    );
  }

  void _pickImage(BuildContext context) async {
    final imageSource = await showCupertinoModalPopup<dynamic>(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
                title: const Text('Chọn ảnh từ'),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: const Text('Camera'),
                    onPressed: () {Navigator.pop(context, ImageSource.camera);},
                  ),
                  CupertinoActionSheetAction(
                      child: const Text('Gallery'),
                      onPressed: () {Navigator.pop(context, ImageSource.gallery);})],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Huỷ'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )
            )
    );
    if(imageSource != null && imageSource is ImageSource) {
      Future.delayed(Duration(milliseconds: 100), () async {
        final file = await ImagePicker.pickImage(source: imageSource);
        if(file != null) {
          //Upload image to server. if success
          setState(() {
            urlImageProfile = file;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}