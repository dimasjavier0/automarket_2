import 'package:automarket/Model/GetX/Controller/profile_controller.dart';
import 'package:automarket/Model/Tools/Color/color.dart';
import 'package:automarket/Model/Tools/Font/font.dart';
import 'package:automarket/ViewModel/Profile/profile.dart';
import 'package:automarket/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Friends extends StatefulWidget {
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  //final int id;
  var friends = [];

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final ProfileFunctions profileFunctions =
        profileController.profileFunctions;
    final userName = profileController.information.userName;

    return Scaffold(
      appBar: AppBar(
        title: Text('MyFriends'),
        backgroundColor: Color.fromRGBO(18, 159, 177, 1),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Widget profileItem(
      {required String itemName,
      required CustomTextStyle textStyle,
      required CustomColors colors,
      required GestureTapCallback callback}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemName,
                  style: textStyle.bodyNormal.copyWith(fontSize: 25),
                ),
                CupertinoButton(
                  onPressed: callback,
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    color: colors.blackColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 2,
            width: Get.mediaQuery.size.width,
            color: colors.captionColor,
          )
        ],
      ),
    );
  }
}
