import 'dart:async';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../utils/utils.dart';
import '../../view/home/home_view.dart';
class SplashServices{
  static isFirstTime({required BuildContext context})async{
    bool permission=await Utils.requestPermission();
    Timer(const Duration(milliseconds: 1500), () async {
      if(permission){
        Utils.go(context: context, screen: const HomeView(),replace: true);
      }else{
        await openAppSettings();
      }
    });


    // SharedPreferences pref=await SharedPreferences.getInstance();
    // final check=pref.getBool('OPENED') ?? false;
    // Timer(const Duration(seconds: 2), () {
    //   if(check){
    //     Utils.go(context: context, screen: const HomeView(),replace: true);
    //   }else{
    //     Utils.go(context: context, screen: const OnBoarding(),replace: true);
    //   }
    // });
  }

}