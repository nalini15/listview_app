import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/widgetFunction.dart';
import 'package:flutter_application_1/navigations/navigationAnimation.dart';
import 'package:flutter_application_1/provider/userPro.dart';
import 'package:flutter_application_1/screens/articleScreen.dart';
import 'package:flutter_application_1/styles/colors.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../functions/widgetFunction.dart';
import '../navigations/navigationAnimation.dart';
import 'articleScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formData = {"username": "", "email": "", "password": ""};

  Future<void> _submitLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final userPro = Provider.of<UserPro>(context, listen: false);
      final response = await userPro.loginUser({"user": formData});
      if (!response['status']) {
        showSnack(context, response['msg'], _scaffoldkey);
      } else {
        showSnack(context, response['msg'], _scaffoldkey, true);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, FadeNavigation(widget: ArticleScreen()));
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.black.withOpacity(0.1),
      body: SafeArea(
        top: Platform.isIOS ? false : true,
        bottom: Platform.isIOS ? false : true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          //height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/img.png",
            ),
          )),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  buildSizedBoxHeight(35),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              autocorrect: true,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                              validator: (value) {
                                if (value.trimRight().trimLeft().isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                formData['username'] =
                                    value.trimLeft().trimRight();
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  // FontAwesomeIcons.user,
                                  color: whiteTextColor,
                                ),
                                errorStyle: TextStyle(
                                  color: whiteTextColor,
                                ),
                                hintText: 'UserName',
                                //contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintStyle:
                                    normalStyle.copyWith(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteTextColor),
                                ),
                              )),
                          buildSizedBoxHeight(35),
                          TextFormField(
                              autocorrect: true,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value.trimRight().trimLeft());
                                if (value.trimRight().trimLeft().isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!emailValid) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                formData['email'] =
                                    value.trimLeft().trimRight();
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  // FontAwesomeIcons.user,
                                  color: whiteTextColor,
                                ),
                                errorStyle: TextStyle(
                                  color: whiteTextColor,
                                ),
                                hintText: 'Email',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                isDense: true,
                                hintStyle:
                                    normalStyle.copyWith(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteTextColor),
                                ),
                              )),
                          buildSizedBoxHeight(35),
                          TextFormField(
                              autocorrect: true,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                              validator: (value) {
                                if (value.trimRight().trimLeft().isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length > 20) {
                                  return 'Password should be max 20 characters!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                formData['password'] =
                                    value.trimLeft().trimRight();
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesomeIcons.user,
                                  color: whiteTextColor,
                                ),
                                errorStyle: TextStyle(
                                  color: whiteTextColor,
                                ),
                                hintText: 'Password',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                isDense: true,
                                hintStyle:
                                    normalStyle.copyWith(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteTextColor),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  buildSizedBoxHeight(40),
                  Consumer<UserPro>(
                    builder: (con, userPro, _) => userPro.isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: 50,
                            width: buildWidth(context) / 1.3,
                            child: RaisedButton(
                                color: buttonCOlor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  _submitLogin();
                                },
                                child: Text(
                                  "Login",
                                  style: buttonStyle.copyWith(fontSize: 18),
                                )),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
