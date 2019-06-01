import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/services/app_notifications.dart';
import 'package:flutterhackathon/services/auth.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/Utils/app_constants.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_alerts.dart';
import 'package:flutterhackathon/components/app_button.dart';
import 'package:flutterhackathon/components/backgroud_image_widget.dart';
import 'package:flutterhackathon/components/custom_text_form_dield.dart';
import 'package:flutterhackathon/models/user_model.dart';
import 'package:flutterhackathon/screens/home/home_screen.dart';
import 'package:flutterhackathon/screens/profile/complete_profile.dart';
import 'package:flutterhackathon/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone = "";
  String _otp = "";
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('LoginScreen');

  final _numberFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();

  FirebaseUser _firebaseUser;

  String _verificationId = "";

  int _verifyTimeOutInSeconds = 15;

  PageState _pageState = PageState.Loaded;
  int _currentPage = 0;

  PageController _pageController;

  String _mobileNumber = "";

  @override
  void initState() {
    super.initState();
    appLogs("LoginScreen", tag: "Screen");

    _pageController = new PageController();
  }

  phoneVerificationCompleted(AuthCredential phoneAuthCredential) async {
    _firebaseUser = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

    if (Platform.isAndroid) {
      showSnackBar(
        title: Strings.autoVerificationCompleted,
        scaffoldKey: _scaffoldKey,
        color: Colors.green,
      );

      Future.delayed(
        Duration(milliseconds: 1000),
        () => autoVerified(),
      );
    }
  }

  Widget _mobileNumberScreenWidget() {
    return Form(
      key: _numberFormKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s25,
            ),
            child: Text(
              "Register",
              style: TextStyles.headingTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s10,
            ),
            child: Text(
              "Let’s create your account. Please enter your mobile number",
              style: TextStyles.headingTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s50,
            ),
            child: Image(height: screenHeight * 0.323, image: AssetImage(Assets.iconConfiti)),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Sizes.s20,
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.s30),
            child: AppTextFormField(
              validator: FieldValidator.validatePhone,
              onSaved: (value) => _phone = value.trim(),
              hintText: Strings.enterPhone,
              labelText: Labels.mobileNumber,
              maxLength: 10,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) => sendOTP(),
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Sizes.s20,
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            child: AppButton(
              title: "Request OTP",
              onTap: () => sendOTP(),
            ),
          ),
          C10(),
        ],
      ),
    );
  }

  Widget _oTPScreenWidget() {
    return Form(
      key: _otpFormKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s25,
            ),
            child: Text(
              "Verification",
              style: TextStyles.headingTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s10,
            ),
            child: Text(
              "Please enter the OTP that\n you have recived.",
              style: TextStyles.headingTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            margin: EdgeInsets.only(
              top: Sizes.s25,
            ),
            child: Image(
              height: screenHeight * 0.323,
              image: AssetImage(
                Assets.iconAccess,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Sizes.s15,
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.s30),
            child: AppTextFormField(
              validator: FieldValidator.validatePhone,
              onSaved: (value) => _otp = value.trim(),
              hintText: Strings.enterPhone,
              labelText: Labels.mobileNumber,
              maxLength: 13,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {},
              textInputAction: TextInputAction.done,
              initialValue: "$_phone",
              enabled: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Sizes.s1,
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.s30),
            child: AppTextFormField(
              validator: FieldValidator.validateOTP,
              onSaved: (value) => _otp = value.trim(),
              hintText: Strings.enterOTP,
              labelText: Strings.enterOTP,
              maxLength: 6,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {},
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Sizes.s15,
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
            child: AppButton(
              title: "Login",
              onTap: () => verifyOTP(),
            ),
          ),
          C10(),
        ],
      ),
    );
  }

  updateCurrentPage(int page) {
    setState(() {
      _currentPage = page;
    });
    appLogs("_currentPage:$_currentPage");
  }

  gotoPage(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.easeIn);
  }

  void sendOTP() async {
    if (!isFormValid(_numberFormKey)) return;

    showLoading();

    _mobileNumber = '+91 $_phone';

    appLogs('sendOTP mobileNumer:$_mobileNumber');

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      appLogs('verificationFailed ${error.message}');

      hideLoading();

      showErrorAlert(context: context, message: error.message);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) {
      appLogs('codeSent');

      _verificationId = verificationId;

      hideLoading();

      gotoPage(1);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      appLogs('codeAutoRetrievalTimeout');
      _verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _mobileNumber,
      timeout: Duration(seconds: _verifyTimeOutInSeconds),
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verifyOTP() async {
    appLogs('verifyOTP : $_verificationId');
    if (isFormValid(_otpFormKey)) {
      showLoading();

      var _error;
      try {
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: _verificationId,
          smsCode: _otp,
        );
        _firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        _error = e;
      }

      if (_firebaseUser != null) {
        await verificationCompleted();
      } else {
        appLogs('verificationFailed ${_error.message}');

        hideLoading();

        showErrorAlert(context: context, message: Strings.invalidOTP);
      }
    }
  }

  autoVerified() async {
    showLoading();

    await verificationCompleted(); //.timeout(timeOutDuration, onTimeout: () => onTimeout(context));
  }

  Future<Null> verificationCompleted() async {
    DataSnapshot userDS = await userRef.child(_firebaseUser.uid).once();

    if (userDS != null && userDS.value != null) {
      User user = new User.fromSnapshot(snapshot: userDS, tempUID: _firebaseUser.uid);
      auth.currentUser = user;
      await updateUserInSharedPreference();

      AppRoutes.makeFirst(context, HomeScreen());
    } else {
      String authToken = await _firebaseUser.getIdToken();

      auth.currentUser = User(
        loggedIn: false,
        uid: _firebaseUser.uid,
        name: "",
        email: "",
        phone: _phone,
        authToken: authToken,
        fcmToken: AppNotifications.fcmToken,
        profileImageUrl: "",
      );
      await updateUserInSharedPreference();

      AppRoutes.makeFirst(context, CompleteProfileScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          BackgroundWidget(
            image: Assets.bgScreen,
          ),
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: updateCurrentPage,
            children: <Widget>[
              _mobileNumberScreenWidget(),
              _oTPScreenWidget(),
            ],
          ),
          getLoaderWidget()
        ],
      ),
    );
  }

  Widget getLoaderWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Offstage(
        offstage: _pageState != PageState.Loading,
        child: FullScreenLoader(),
      ),
    );
  }

  showLoading() {
    appLogs("---showLoading----");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("---hideLoading----");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("---showError----");

    setState(() => _pageState = PageState.Error);
  }
}
