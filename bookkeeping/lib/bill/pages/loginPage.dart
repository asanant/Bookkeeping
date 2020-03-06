import 'dart:convert';
import 'package:bookkeeping/bill/pages/registerPage.dart';
import 'package:bookkeeping/res/colours.dart';
import 'package:bookkeeping/routers/fluro_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  VoidCallback callback;
  @override
  LoginState createState() => LoginState();

  LoginPage(this.callback);
}

class LoginState extends State<LoginPage> {
  String mPhone = "";
  String mPwd = "";
  bool isLoading = false;
  bool mIsShowPassWord = false;

  String wxCode;

  var wxListen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    wxListen.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            FlatButton(
              child: Text('注册',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(35), color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    builder:(context){ return RegisterPage((){
                      widget.callback();
                    });}));
              },
            )
          ],
          title: Text(
            '登录',
            style: TextStyle(fontSize: ScreenUtil().setSp(35)),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(66)),
                  Container(
                    height:ScreenUtil().setWidth(100),
                    width: ScreenUtil().setWidth(570),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(width: 0.8, color: Color(0xFFDDDDDD))),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: ScreenUtil().setWidth(20)),
                        Image.asset(
                          'assets/images/ic_login_account.png',
                          fit: BoxFit.contain,
                          width: ScreenUtil().setWidth(36),
                          height: ScreenUtil().setWidth(36),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(14)),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                            decoration: InputDecoration(
                              hintText: "请输入用户名",
                              hintStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  color: Color(0xFFC6C6C6),textBaseline: TextBaseline.alphabetic),
                              border: InputBorder.none,
                            ),

                            onChanged: (value) {
                              setState(() {
                                mPhone = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height:ScreenUtil().setWidth(100),
                    width: ScreenUtil().setWidth(570),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(width: 0.8, color: Color(0xFFDDDDDD))),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: ScreenUtil().setWidth(20)),
                        Image.asset(
                          'assets/images/ic_login_pwd.png',
                          fit: BoxFit.contain,
                          width: ScreenUtil().setWidth(36),
                          height: ScreenUtil().setWidth(36),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(14)),
                        Expanded(
                          child: TextField(
                            obscureText: !mIsShowPassWord,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                            decoration: InputDecoration(
                              hintText: "请输入密码",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  color: Color(0xFFC6C6C6),textBaseline: TextBaseline.alphabetic),
                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  !mIsShowPassWord
                                      ? 'assets/images/ic_login_uneye.png'
                                      : 'assets/images/ic_eye_pwd.png',
                                  fit: BoxFit.contain,
                                  width: ScreenUtil().setWidth(36),
                                  height: ScreenUtil().setWidth(36),
                                ),
                                onPressed: showPassWord,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                mPwd = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ), //密码
                  SizedBox(height: ScreenUtil().setHeight(60)),

                  FlatButton(
                    child: Container(
                      width: ScreenUtil().setWidth(594),
                      height: ScreenUtil().setWidth(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color:Colours.app_main),
                      child: Center(
                          child: Text(
                            "登录",
                            style: TextStyle(fontSize: ScreenUtil().setSp(36), color: Colors.white),
                          )),
                    ),
                    onPressed:(){
                      {
                        if (mPhone.isEmpty) {
                          showToast("用户名不能为空");
                          return;
                        }
                        if (mPwd.isEmpty) {
                          showToast("密码不能为空");
                          return;
                        }
                        doLogin();
                      }
                    },
                  ),
            

                ],
              ),
            ),
          ),
        ));
  }

  //登录
  void doLogin() {
    SharedPreferences.getInstance().then((sp){
     var pwd= sp.getString(mPhone);
      if(pwd!=null&&pwd.trim()==mPwd){
        sp.setBool("login_state", true);
        widget.callback();
      }else{
       showToast("用户名或者密码错误");
      }
    }).catchError((){
      showToast("用户名或者密码错误");
    });
  }

  // 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      mIsShowPassWord = !mIsShowPassWord;
    });
  }

  //登录
}
