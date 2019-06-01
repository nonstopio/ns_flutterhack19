import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class API {
  static String baseURL = "";
}

int timeOutInSeconds = 30;
int uploadTimeOutInSeconds = 180;

Future<Map<String, dynamic>> getDataFromPOSTAPI({
  @required String apiName,
  @required Map<String, dynamic> parameterData,
  @required BuildContext context,
  @required bool popAfter,
  bool logEnabled = true,
  String customErrorMessage,
}) async {
  Map<String, dynamic> responseData = new Map();

  String url = API.baseURL + apiName;

  bool errorFlag = false;
  bool timeOutFlag = false;

  String requestData = json.encode(parameterData);

  if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName with URL = $url");
  if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName with Request Data = $requestData");

  try {
    await http
        .post(Uri.encodeFull(url),
            headers: {
              "Accept": "application/json",
            },
            body: requestData)
        .catchError((onError) {
      if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName has Error");

      errorFlag = true;
    }).timeout(new Duration(seconds: timeOutInSeconds), onTimeout: () async {
      if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName has TimeOut");

      timeOutFlag = true;
    }).then((response) {
      if (response != null && !timeOutFlag && !errorFlag) {
        if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName has Response statusCode:${response.statusCode}");
        if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName has Response body:${response.body}");
        responseData = json.decode(response.body);
        responseData.putIfAbsent("statusCode", () => response.statusCode);
      }
    });
  } catch (exception, stackTrace) {
    if (logEnabled) apiLogs(exception);
    if (logEnabled) apiLogs(stackTrace);
  }

  if (popAfter) {
    AppRoutes.pop(context);
    if (logEnabled) apiLogs("getDataFromPOSTAPI : popAfter $popAfter");
  } else {
    if (logEnabled) apiLogs("getDataFromPOSTAPI : popAfter $popAfter");
  }

  if (errorFlag) {
    if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName Show Error");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  } else if (timeOutFlag) {
    if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName Show TimeOut  ");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 99999);
    responseData.putIfAbsent("message", () => Strings.timeOutMessage);
  }

  if (responseData.isEmpty) {
    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  }

  if (logEnabled) apiLogs("getDataFromPOSTAPI : $apiName has Response: " + responseData.toString());

  int statusCode = responseData['statusCode'];

  return responseData;
}

String getFileName(String filePath) {
  return basename(filePath);
}

Future<Map<String, dynamic>> uploadFilePOSTAPI(
    {@required String apiName,
    @required String enrolmentNo,
    @required String type,
    @required File file,
    @required BuildContext context,
    @required bool popAfter,
    bool logEnabled = true,
    String customErrorMessage}) async {
  Map<String, dynamic> responseData = new Map();

  String url = API.baseURL + apiName;

  bool errorFlag = false;
  bool timeOutFlag = false;

  if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName with URL = $url");
  if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName with Request Data = enrolmentNo:$enrolmentNo, type : $type");

  try {
    FormData formData = new FormData.from({
      "enrolmentNo": "$enrolmentNo", // Other Field
      "type": "$type", // Other Field
      "image": new UploadFileInfo(file, basename(file.path)),
    });

    Dio dio = new Dio();

    await dio
        .post(Uri.encodeFull(url),
            data: formData,
            options: Options(
              headers: {
                "Accept": "application/json",
              },
            ))
        .catchError((onError) {
      if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has Error $onError");

      errorFlag = true;
    }).timeout(new Duration(seconds: uploadTimeOutInSeconds), onTimeout: () async {
      if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has TimeOut");

      timeOutFlag = true;
    }).then((response) {
      if (response != null && !timeOutFlag && !errorFlag) {
        if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has Response :${response.toString()}");
        if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has Response statusCode:${response.statusCode}");
        if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has Response body:${response.data}");
        responseData = response.data;
        responseData.putIfAbsent("statusCode", () => response.statusCode);
      }
    });
  } catch (exception, stackTrace) {
    if (logEnabled) apiLogs(exception);
    if (logEnabled) apiLogs(stackTrace);
  }

  if (popAfter) {
    AppRoutes.pop(context);
    if (logEnabled) apiLogs("uploadFilePOSTAPI : popAfter $popAfter");
  } else {
    if (logEnabled) apiLogs("uploadFilePOSTAPI : popAfter $popAfter");
  }

  if (errorFlag) {
    if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName Show Error");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  } else if (timeOutFlag) {
    if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName Show TimeOut  ");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 99999);
    responseData.putIfAbsent("message", () => Strings.timeOutMessage);
  }

  if (responseData.isEmpty) {
    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  }

  if (logEnabled) apiLogs("uploadFilePOSTAPI : $apiName has Response: " + responseData.toString());

  int statusCode = responseData['statusCode'];

  return responseData;
}

Future<Map<String, dynamic>> getDataFromGETAPI({
  @required String apiName,
  @required BuildContext context,
  @required bool popAfter,
  bool useBaseURL = true,
  bool logEnabled = true,
  String customErrorMessage,
}) async {
  Map<String, dynamic> responseData = new Map();

  String url = useBaseURL ? (API.baseURL + apiName) : apiName;

  bool errorFlag = false;
  bool timeOutFlag = false;

  if (logEnabled) apiLogs("getDataFromGETAPI : $apiName with URL = $url");

  try {
    await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json",
      },
    ).catchError((onError) {
      if (logEnabled) apiLogs("getDataFromGETAPI : $apiName has Error");

      errorFlag = true;
    }).timeout(new Duration(seconds: timeOutInSeconds), onTimeout: () async {
      if (logEnabled) apiLogs("getDataFromGETAPI : $apiName has TimeOut ");

      timeOutFlag = true;
    }).then((response) {
      if (response != null && !timeOutFlag && !errorFlag) {
        if (logEnabled) apiLogs("getDataFromGETAPI : $apiName has Response statusCode:${response.statusCode}");
        if (logEnabled) apiLogs("getDataFromGETAPI : $apiName has Response body:${response.body}");
        responseData = json.decode(response.body);
        responseData.putIfAbsent("statusCode", () => response.statusCode);
      }
    });
  } catch (exception, stackTrace) {
    if (logEnabled) apiLogs(exception);
    if (logEnabled) apiLogs(stackTrace);
  }

  if (popAfter) {
    AppRoutes.pop(context);
    if (logEnabled) apiLogs("getDataFromGETAPI : popAfter $popAfter");
  } else {
    if (logEnabled) apiLogs("getDataFromGETAPI : popAfter $popAfter");
  }

  if (errorFlag) {
    if (logEnabled) apiLogs("getDataFromGETAPI : $apiName Show Error");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  } else if (timeOutFlag) {
    if (logEnabled) apiLogs("getDataFromGETAPI : $apiName Show TimeOut ");

    responseData.clear();

    responseData.putIfAbsent("statusCode", () => 99999);
    responseData.putIfAbsent("message", () => Strings.timeOutMessage);
  }

  if (responseData.isEmpty) {
    responseData.putIfAbsent("statusCode", () => 0);
    responseData.putIfAbsent("message", () => Strings.somethingWentWrong);
  }

  if (logEnabled) apiLogs("getDataFromGETAPI : $apiName has Response: " + responseData.toString());

  int statusCode = responseData['statusCode'];

  return responseData;
}

Future<Null> launchURL(String url) async {
  try {
    url = Uri.encodeFull(url);
    appLogs('\n\nURL: $url \n\n');
    await launch(url.toString(), forceSafariVC: false, forceWebView: false);
  } catch (e) {
    appLogs('\n\nError in launchURL: $e\n\n');
  }
}
