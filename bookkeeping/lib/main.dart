import 'dart:async';
import 'dart:io';
import 'package:bookkeeping/main/main_page.dart';
import 'package:bookkeeping/res/colours.dart';
import 'package:bookkeeping/routers/application.dart';
import 'package:bookkeeping/routers/routers.dart';
import 'package:bookkeeping/widgets/splash_start.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bill/pages/loginPage.dart';

void main() {
  //透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {
    // 初始化路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }


}
class MyAppState extends State<MyApp>{
  bool isPlash=true;
  bool isLogin=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        isPlash=false;
      });
    });
    SharedPreferences.getInstance().then((sp){
      if(sp.getBool("login_state")!=null){
        setState(() {isLogin=true;});
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        // showPerformanceOverlay: true,
        // debugShowMaterialGrid: true,
        title: '土豆记账',
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colours.app_main,
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(),
            cupertinoOverrideTheme: CupertinoThemeData(
              brightness: Brightness.dark,
              primaryContrastingColor: Colors.white,
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              barBackgroundColor: Colours.app_main,
            )),
        home:isPlash? SplashPage():isLogin ? MainPage():LoginPage((){
          setState(() {
            isLogin=true;
          });
        }),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      radius: 20,
      position: ToastPosition.bottom,
    );
  }

}
