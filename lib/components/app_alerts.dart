import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/theme/theme.dart';

enum ButtonType { positiveButton, negativeButton }

enum AlertType {
  Success,
  Warning,
  Error,
  Internet,
}

enum MediaAlertType {
  AUDIO,
  IMAGE,
  VIDEO,
}

void showImagePickerAlert({
  @required BuildContext context,
  @required GestureTapCallback galleryCallback,
  @required GestureTapCallback cameraCallback,
  bool barrierDismissible = false,
}) {
  showDialog(
    context: context,
    builder: (_) => ImagePickerAlert(
          galleryCallback: galleryCallback,
          cameraCallback: cameraCallback,
        ),
    barrierDismissible: barrierDismissible,
  );
}

void showAlert({@required BuildContext context, @required String message, bool barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: () {},
          alertType: AlertType.Success,
          message: message,
        ),
    barrierDismissible: barrierDismissible,
  );
}

void showAlertWithTwoOption(
    {@required BuildContext context,
    @required String message,
    @required AlertType alertType,
    @required GestureTapCallback positiveButtonOnTap,
    @required GestureTapCallback negativeButtonOnTap,
    String positiveButtonText,
    String negativeButtonText,
    String image,
    bool popAfter = true,
    bool barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
        alertType: alertType,
        message: message,
        positiveButtonText: positiveButtonText,
        positiveButtonOnTap: positiveButtonOnTap,
        negativeButtonText: negativeButtonText,
        negativeButtonOnTap: negativeButtonOnTap,
        popAfter: popAfter,
        image: image,
        barrierDismissible: barrierDismissible),
  );
}

void showAlertWithTwoOptionForMedia(
    {@required BuildContext context,
    @required MediaAlertType mediaAlertType,
    @required GestureTapCallback positiveButtonOnTap,
    @required GestureTapCallback negativeButtonOnTap,
    String positiveButtonText,
    String negativeButtonText,
    bool popAfter = true,
    bool barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlertMedia(
          positiveButtonText: positiveButtonText,
          positiveButtonOnTap: positiveButtonOnTap,
          negativeButtonText: negativeButtonText,
          negativeButtonOnTap: negativeButtonOnTap,
          popAfter: popAfter,
          mediaAlertType: mediaAlertType,
          barrierDismissible: barrierDismissible,
        ),
  );
}

void showErrorAlert({@required BuildContext context, String message, bool barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: () {},
          alertType: AlertType.Error,
          message: message,
          barrierDismissible: barrierDismissible,
        ),
  );
}

void showSimpleAlert({
  @required BuildContext context,
  @required String message,
  @required String positiveButtonText,
  @required GestureTapCallback positiveButtonOnTap,
  bool barrierDismissible = false,
  AlertType alertType = AlertType.Error,
}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: positiveButtonOnTap,
          positiveButtonText: positiveButtonText,
          alertType: alertType,
          message: message,
          barrierDismissible: barrierDismissible,
        ),
  );
}

void showWarningAlert({@required BuildContext context, @required String message, barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: () {},
          alertType: AlertType.Warning,
          message: message,
          barrierDismissible: barrierDismissible,
        ),
  );
}

void showWIPAlert({@required BuildContext context, barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: () {},
          alertType: AlertType.Success,
          message: Strings.wip,
          barrierDismissible: barrierDismissible,
        ),
  );
}

void showEXITAlert({@required BuildContext context, barrierDismissible = false}) {
  showDialog(
    context: context,
    builder: (_) => AppAlert(
          positiveButtonOnTap: () {},
          alertType: AlertType.Warning,
          message: Strings.exit,
          negativeButtonOnTap: () {
            SystemNavigator.pop();
          },
          negativeButtonText: Strings.negativeButtonText,
          positiveButtonText: Strings.positiveButtonText,
          barrierDismissible: barrierDismissible,
        ),
  );
}

class AppAlert extends StatefulWidget {
  final String message;
  final String image;
  final AlertType alertType;
  final String positiveButtonText;
  final String negativeButtonText;
  final GestureTapCallback positiveButtonOnTap;
  final GestureTapCallback negativeButtonOnTap;
  final bool popAfter;
  final bool barrierDismissible;

  AppAlert({
    @required this.message,
    @required this.alertType,
    @required this.positiveButtonOnTap,
    this.negativeButtonOnTap,
    this.positiveButtonText,
    this.negativeButtonText,
    this.popAfter = true,
    this.barrierDismissible = false,
    this.image,
  });

  @override
  _AppAlertState createState() => _AppAlertState();
}

class _AppAlertState extends State<AppAlert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  popAlert() async {
    if (widget.popAfter) {
      appLogs("Alert-------------> poped");
      AppRoutes.dismissAlert(context);
    }
  }

  Widget getAlertBody() {
    return Center(
      child: Container(
        constraints: BoxConstraints(minHeight: Sizes.alertHeight),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.s15),
                padding: EdgeInsets.only(top: Sizes.s10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1.0,
                      blurRadius: screenWidth,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(Sizes.s8),
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getAlertIcon(widget.alertType, widget.image),
                      Padding(
                        padding: EdgeInsets.all(Sizes.s10),
                        child: Text(
                          widget.message,
                          style: TextStyles.alertText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.fromRadius(Sizes.s10),
                      ),
                      (widget.negativeButtonText == null && widget.negativeButtonOnTap == null)
                          ? AlertButton(
                              buttonType: ButtonType.positiveButton,
                              text: widget.positiveButtonText,
                              callback: () async {
                                popAlert();
                                widget.positiveButtonOnTap();

                                appLogs("Alert-------------> positiveButton");
                              },
                            )
                          : Wrap(
                              alignment: WrapAlignment.start,
                              children: <Widget>[
                                AlertButton(
                                  buttonType: ButtonType.positiveButton,
                                  text: widget.positiveButtonText,
                                  callback: () async {
                                    popAlert();

                                    widget.positiveButtonOnTap();

                                    appLogs("Alert-------------> positiveButton");
                                  },
                                ),
                                AlertButton(
                                  buttonType: ButtonType.negativeButton,
                                  text: widget.negativeButtonText,
                                  callback: () async {
                                    popAlert();

                                    widget.negativeButtonOnTap();

                                    appLogs("Alert-------------> negativeButton");
                                  },
                                ),
                              ],
                            ),
                      Container(
                        margin: EdgeInsets.only(
                          top: Sizes.s10,
                        ),
                        height: Sizes.s8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(Sizes.s5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.barrierDismissible
          ? () {
              AppRoutes.dismissAlert(context);
            }
          : () {},
      child: Material(
        color: Colors.transparent,
        child: widget.barrierDismissible
            ? Stack(
                children: <Widget>[
                  InkWell(onTap: () => popAlert(), child: Container()),
                  getAlertBody(),
                ],
              )
            : getAlertBody(),
      ),
    );
  }
}

class AppAlertMedia extends StatefulWidget {
  final MediaAlertType mediaAlertType;
  final String positiveButtonText;
  final String negativeButtonText;
  final GestureTapCallback positiveButtonOnTap;
  final GestureTapCallback negativeButtonOnTap;
  final bool popAfter;
  final bool barrierDismissible;

  AppAlertMedia({
    @required this.mediaAlertType,
    @required this.positiveButtonOnTap,
    this.negativeButtonOnTap,
    this.positiveButtonText,
    this.negativeButtonText,
    this.popAfter = true,
    this.barrierDismissible = false,
  });

  @override
  _AppAlertMediaState createState() => _AppAlertMediaState();
}

class _AppAlertMediaState extends State<AppAlertMedia> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  popAlert() async {
    if (widget.popAfter) {
      appLogs("Alert-------------> poped");
      AppRoutes.dismissAlert(context);
    }
  }

  Widget getAlertBody() {
    return Center(
      child: Container(
        constraints: BoxConstraints(minHeight: Sizes.alertHeight),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.s15),
                padding: EdgeInsets.only(top: Sizes.s10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1.0,
                      blurRadius: screenWidth,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(Sizes.s8),
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getMediaAlertIcon(widget.mediaAlertType),
                      SizedBox.fromSize(
                        size: Size.fromRadius(Sizes.s10),
                      ),
                      (widget.negativeButtonText == null && widget.negativeButtonOnTap == null)
                          ? AlertButton(
                              buttonType: ButtonType.positiveButton,
                              text: widget.positiveButtonText,
                              callback: () async {
                                popAlert();
                                widget.positiveButtonOnTap();

                                appLogs("Alert-------------> positiveButton");
                              },
                            )
                          : Wrap(
                              alignment: WrapAlignment.start,
                              children: <Widget>[
                                AlertButton(
                                  buttonType: ButtonType.positiveButton,
                                  text: widget.positiveButtonText,
                                  callback: () async {
                                    popAlert();

                                    widget.positiveButtonOnTap();

                                    appLogs("Alert-------------> positiveButton");
                                  },
                                ),
                                AlertButton(
                                  buttonType: ButtonType.negativeButton,
                                  text: widget.negativeButtonText,
                                  callback: () async {
                                    popAlert();

                                    widget.negativeButtonOnTap();

                                    appLogs("Alert-------------> negativeButton");
                                  },
                                ),
                              ],
                            ),
                      Container(
                        margin: EdgeInsets.only(
                          top: Sizes.s10,
                        ),
                        height: Sizes.s8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(Sizes.s5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.barrierDismissible
          ? () {
              AppRoutes.dismissAlert(context);
            }
          : () {},
      child: Material(
        color: Colors.transparent,
        child: widget.barrierDismissible
            ? Stack(
                children: <Widget>[
                  InkWell(onTap: () => popAlert(), child: Container()),
                  getAlertBody(),
                ],
              )
            : getAlertBody(),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  final String text;
  final GestureTapCallback callback;
  final ButtonType buttonType;

  const AlertButton({
    Key key,
    this.text,
    @required this.callback,
    @required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getMaxWidth() {
      double maxWidth = screenWidth - Sizes.s40;
      if (text != null) {
        maxWidth = text.length < 10 ? Sizes.s150 : maxWidth;
      }
      return maxWidth;
    }

    return InkWell(
      child: Container(
        constraints: BoxConstraints(
          minHeight: Sizes.s40,
          maxHeight: Sizes.s40,
          maxWidth: getMaxWidth(),
          minWidth: Sizes.minWidthAlertButton,
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s5),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: Sizes.s5),
        child: Center(
          child: Text(
            (buttonType == ButtonType.positiveButton)
                ? (text ?? Strings.positiveButtonText.toUpperCase())
                : (text ?? Strings.negativeButtonText.toUpperCase()),
            style: (buttonType == ButtonType.positiveButton)
                ? TextStyles.alertButtonText.copyWith(color: AppColors.primary)
                : TextStyles.alertButtonText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: callback,
    );
  }
}

Widget getAlertIcon(AlertType type, String asset) {
  String image = Assets.alertSuccess;

  switch (type) {
    case AlertType.Success:
      image = Assets.alertSuccess;
      break;
    case AlertType.Warning:
      image = Assets.alertWarning;
      break;

    case AlertType.Error:
      image = Assets.alertError;
      break;

    case AlertType.Internet:
      image = Assets.alertError;
      break;
  }

  return Image(
    image: AssetImage(asset ?? image),
    height: Sizes.s80,
  );
}

Widget getMediaAlertIcon(MediaAlertType type) {
  Widget child = new Container();
  switch (type) {
    case MediaAlertType.AUDIO:
      child = Icon(
        Icons.mic,
        color: Colors.blue,
        size: Sizes.s50,
      );
      break;
    case MediaAlertType.IMAGE:
      child = Icon(
        Icons.image,
        color: Colors.blue,
        size: Sizes.s50,
      );
      break;
    case MediaAlertType.VIDEO:
      child = Icon(
        Icons.videocam,
        color: Colors.blue,
        size: Sizes.s50,
      );
      break;
  }

  return child;
}

class ImagePickerAlert extends StatefulWidget {
  final GestureTapCallback galleryCallback;
  final GestureTapCallback cameraCallback;

  const ImagePickerAlert({Key key, @required this.galleryCallback, @required this.cameraCallback}) : super(key: key);

  @override
  _ImagePickerAlertState createState() => _ImagePickerAlertState();
}

class _ImagePickerAlertState extends State<ImagePickerAlert> with TickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: AlertDialog(
        contentPadding: EdgeInsets.all(Sizes.s5),
        content: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkResponse(
                    child: Padding(
                      padding: EdgeInsets.all(Sizes.s8),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            size: Sizes.s50,
                            color: AppColors.primary,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Sizes.s5),
                            child: Text(
                              "Gallery",
                              style: TextStyles.alertText,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      widget.galleryCallback();
                      AppRoutes.dismissAlert(context);
                    },
                  ),
                  InkResponse(
                    child: Padding(
                      padding: EdgeInsets.all(Sizes.s8),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            size: Sizes.s50,
                            color: Colors.blueAccent,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Sizes.s5),
                            child: Text(
                              "Camera",
                              style: TextStyles.alertText,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      widget.cameraCallback();
                      AppRoutes.dismissAlert(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.s10),
              ),
              AlertButton(
                buttonType: ButtonType.negativeButton,
                callback: () async {
                  AppRoutes.dismissAlert(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
