import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertask/store/login/login.dart';
import 'package:fluttertask/utils/bubble_indication_painter.dart';
import '../utils/curve.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Login login = Login();
  PageController _pageController;
  TextEditingController loginUsername;
  TextEditingController loginPassword;
  TextEditingController signUpUsername;
  TextEditingController signUpPassword;
  TextEditingController email;
  Color left = Colors.white;
  Color right = Colors.white24;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF1D2236),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
          ),
          NotificationListener<OverscrollIndicatorNotification>(
            // ignore: missing_return
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (i) {
                            setPage(i);
                          },
                          children: <Widget>[
                            _buildSignIn(context),
                            _buildSignUp(context),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _buildMenuBar(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFFED5E58),
                                  fontSize: 16.0),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/logo.png',
                  height: MediaQuery.of(context).size.width / 6,
                  width: MediaQuery.of(context).size.width / 6),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loginUsername = TextEditingController();
    loginPassword = TextEditingController();
    signUpUsername = TextEditingController();
    signUpPassword = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B).withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Observer(
                  builder: (_) => Text(
                    "Login",
                    style: TextStyle(
                      color: login.left,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Observer(
                  builder: (_) => Text(
                    "Sign Up",
                    style: TextStyle(
                      color: login.right,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: loginUsername,
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFED5E58)),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFED5E58),
                    ),
                    labelText: "Username",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(
                          color: Color(0xFFED5E58), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    fillColor: Color(0xFFED5E58),
                    errorStyle: TextStyle(color: Color(0xFFED5E58)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: loginPassword,
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFED5E58)),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFED5E58),
                    ),
                    labelText: "Password",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(
                          color: Color(0xFFED5E58), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    fillColor: Color(0xFFED5E58),
                    errorStyle: TextStyle(color: Color(0xFFED5E58)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFED5E58),
                    ),
                    labelText: "Email",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(
                          color: Color(0xFFED5E58), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    fillColor: Color(0xFFED5E58),
                    errorStyle: TextStyle(color: Color(0xFFED5E58)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: signUpUsername,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFED5E58),
                    ),
                    labelText: "Username",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(
                          color: Color(0xFFED5E58), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    fillColor: Color(0xFFED5E58),
                    errorStyle: TextStyle(color: Color(0xFFED5E58)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: signUpPassword,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFED5E58),
                    ),
                    labelText: "Password",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(
                          color: Color(0xFFED5E58), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: const BorderSide(color: Color(0xFFED5E58)),
                    ),
                    fillColor: Color(0xFFED5E58),
                    errorStyle: TextStyle(color: Color(0xFFED5E58)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    if (login.currentPage == 0) {
      if (loginUsername != null && loginPassword != null) {
        if (login.validateLogin(loginUsername.text, loginPassword.text)) {
          _showAlert("Login and Password Validated");
        } else {
          _showAlert(
              'Login and Password Validation Error , please fill correct login or Password ( Password length must bit a bit or exactly 8 characters )');
        }
      }
      else
        _showAlert(
            'Login and Password Validation Error , please fill correct login or Password ( Password length must bit a bit or exactly 8 characters )');
    }
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    if (login.currentPage == 1) {
      if (signUpUsername != null && signUpPassword != null && email != null) {
        if (login.validateSignUp(
            signUpUsername.text, signUpPassword.text, email.text)) {
          _showAlert("Login, Password and Email Validated");
        } else {
          _showAlert(
              'Login and Password Validation Error , please fill correct login or Password ( Password length must bit a bit or exactly 8 characters )');
        }
      } else
        _showAlert(
            'Login and Password Validation Error , please fill correct login or Password ( Password length must bit a bit or exactly 8 characters )');
    }
  }

  void setPage(int i) {
    login.changeCurrentPage(i);
  }

  void _showAlert(String alertText) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Information"),
              content: Text(alertText),
              actions: <Widget>[
                new FlatButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}
