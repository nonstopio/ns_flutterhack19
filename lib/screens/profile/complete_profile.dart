import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_alerts.dart';
import 'package:flutterhackathon/components/app_button.dart';
import 'package:flutterhackathon/components/backgroud_image_widget.dart';
import 'package:flutterhackathon/components/custom_text_form_dield.dart';
import 'package:flutterhackathon/models/user_model.dart';
import 'package:flutterhackathon/screens/home/home_screen.dart';
import 'package:flutterhackathon/services/auth.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/theme/theme.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _completeProfileFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('CompleteProfileScreen');

  bool _imagePicked = false;
  File _image;
  String _imageURL = "";
  String _name;
  String _email;

  String message = "";

  Widget _previewImage() {
    if (_image != null) {
      return Container(
        constraints: BoxConstraints.tightFor(width: Sizes.s120, height: Sizes.s120),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: FileImage(_image),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      constraints: BoxConstraints.tightFor(width: Sizes.s120, height: Sizes.s120),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(
        Icons.person,
        size: Sizes.s80,
        color: Colors.grey[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -Sizes.s150,
            child: BackgroundWidget(),
          ),
          SingleChildScrollView(
            child: Form(
              key: _completeProfileFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: screenWidth,
//              color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s10,
                      vertical: Sizes.s25,
                    ),
                    child: Text(
                      "Profile",
                      style: TextStyles.headingTitle,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s10,
                      vertical: Sizes.s10,
                    ),
                    child: Container(
                      child: AppProfileButton(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => ImagePickerAlert(
                                  cameraCallback: () async {
                                    _image = await ImagePicker.pickImage(
                                      source: ImageSource.camera,
                                      maxHeight: Sizes.s400,
                                      maxWidth: Sizes.s400,
                                    );
                                    setState(() {
                                      if (_image != null) {
                                        _imagePicked = true;
                                      } else {
                                        _imagePicked = false;
                                      }
                                    });
                                  },
                                  galleryCallback: () async {
                                    _image = await ImagePicker.pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: Sizes.s400,
                                      maxWidth: Sizes.s400,
                                    );
                                    setState(() {
                                      if (_image != null) {
                                        _imagePicked = true;
                                      } else {
                                        _imagePicked = false;
                                      }
                                    });
                                  },
                                ),
                          );
                        },
                        image: _previewImage(),
                      ),
                    ),
                  ),
                  P10(),
                  Container(
                    margin: EdgeInsets.only(
                      top: Sizes.s20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
                    child: AppTextFormField(
                      validator: FieldValidator.validateName,
                      onSaved: (value) => _name = value.trim(),
                      hintText: Strings.enterName,
                      labelText: Labels.name,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
                    child: AppTextFormField(
                      validator: FieldValidator.validateEmail,
                      onSaved: (value) => _email = value.trim(),
                      hintText: Strings.enterEmail,
                      labelText: Labels.email,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Sizes.s10),
                    child: AppButton(
                      title: "Submit",
                      onTap: () => submitProfile(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  submitProfile() async {
    if (!isFormValid(_completeProfileFormKey)) return;
    AppRoutes.showLoader(context);

    appLogs('submitProfile');

    if (_imagePicked) {
      _imageURL = await uploadPhoto(_image);
      if (_imageURL == null || _imageURL.isEmpty) {
        AppRoutes.dismissLoader(context);
        showErrorAlert(context: context, message: Strings.somethingWentWrong);
        return;
      }
    } else {
      _imageURL = "";
    }

    auth.currentUser = User(
      loggedIn: true,
      uid: auth.currentUser.uid,
      name: _name,
      email: _email,
      phone: auth.currentUser.phone,
      authToken: auth.currentUser.authToken,
      fcmToken: auth.currentUser.fcmToken,
      profileImageUrl: _imageURL,
    );
    await updateUserInSharedPreference();

    await updateUser();

    await createDefaultCircle();

    AppRoutes.makeFirst(context, HomeScreen());
  }
}
