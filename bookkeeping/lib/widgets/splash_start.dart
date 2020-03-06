import 'package:bookkeeping/res/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashState();
  }

}
class SplashState  extends State<SplashPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Container(
        color: Colours.app_main,
        width: ScreenUtil.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              SizedBox(height: ScreenUtil().setWidth(200),),
             Image.asset("assets/images/icons/ic_launcher.png",width: ScreenUtil().setWidth(180),),
            Text("土豆记账",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

}