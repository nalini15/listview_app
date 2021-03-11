import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/widgetFunction.dart';
import 'package:flutter_application_1/navigations/navigationAnimation.dart';
import 'package:flutter_application_1/screens/articleScreen.dart';
import 'package:flutter_application_1/styles/colors.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String userName, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Container(
        //height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/img.png",
          ),
        )),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              buildSizedBoxHeight(35),
              // _userName(),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                          autocorrect: true,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                          validator: (value) {
                            if (value.trimRight().trimLeft().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
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
                    ),
                    buildSizedBoxHeight(35),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                          autocorrect: true,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                          validator: (value) {
                            if (value.trimRight().trimLeft().isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
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
                    ),
                    buildSizedBoxHeight(35),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                          autocorrect: true,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                          validator: (value) {
                            if (value.trimRight().trimLeft().isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
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
                    ),
                  ],
                ),
              ),
              buildSizedBoxHeight(35),
              Hero(
                tag: 1,
                child: Container(
                  height: 50,
                  width: buildWidth(context) / 1.3,
                  child: RaisedButton(
                      // style: ButtonStyle(
                      //   backgroundColor:
                      // ),
                      color: buttonCOlor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, FadeNavigation(widget: ArticleScreen()));
                      },
                      child: Text(
                        "GOOGLE ACCOUNT",
                        style: buttonStyle,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userName() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 310,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff0c0c0c),
        ),
        child: Form(
          key: _formKey,
          child: TextFormField(
              validator: (val) {
                val = val.trimRight().trimLeft();
                if (val.isEmpty) {
                  return "Please enter your progress";
                }
                return null;
              },
              onSaved: (value) {
                // descritpion =
                //     value.trimRight().trimLeft();
              },
              //textAlign: TextAlign.center,
              autocorrect: true,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.all(0),
                isDense: true,
                hintText: 'UserName',
                hintStyle: TextStyle(
                  color: whiteTextColor,
                  fontFamily: 'Jost',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6A6A6A)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6A6A6A)),
                ),
              )),
        ),
      ),
    );
  }
}
