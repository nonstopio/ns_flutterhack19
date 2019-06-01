import 'package:flutterhackathon/utils/utils.dart';

class FieldValidator {
  static String validateEmail(String value) {
    appLogs("validateEmail : $value ");

    if (value.isEmpty) return Strings.enterEmail;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return Strings.enterValidEmail;
    }

    return null;
  }

  static String validateName(String value) {
    if (value.isEmpty) return Strings.enterName;

    if (value.length < 2) {
      return Strings.enterValidName;
    }

    Pattern pattern = r'^[a-zA-Z\. ]+$';

    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return Strings.enterValidName;
    }

    return null;
  }

  static String validateProfileFields({
    String label,
    String value,
    bool required = false,
  }) {
    if (value.isEmpty && required) return "Enter $label !";

    if (value.isEmpty) return null;

    Pattern pattern = r'^[a-zA-Z\. ]+$';

    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter valid $label !";
    }

    return null;
  }

  static String validateProfileNumberFields({
    String label,
    String value,
    bool required = false,
  }) {
    if (value.isEmpty && required) return "Enter $label !";

    if (value.isEmpty) return null;

    Pattern pattern = r'^[0-9]+$';

    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter valid $label !";
    }

    return null;
  }

  static bool validateDateOfBirth({
    String value,
  }) {
    if (value.isEmpty) return false;

    DateTime tempDateTime = DateTime.tryParse(value);

    return tempDateTime != null;
  }

  static String validatePhone(String value) {
    if (value.isEmpty) return Strings.enterPhone;

//    Pattern pattern = r'^(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[789]\d{9}|(\d[ -]?){10}\d$';
//    Pattern pattern =
//        r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$';
//
//    RegExp regex = new RegExp(pattern);
//
//    if (!regex.hasMatch(value)) {
//      return  AppStrings.enterValidPhone;
//    }

    if (value.contains("/") || value.contains(".") || value.contains(",")) {
      return Strings.enterValidPhone;
    }
    if (value.length < 10) {
      return Strings.enterValidPhone;
    }

    return null;
  }

  static String validateOTP(String value) {
    if (value.isEmpty) return Strings.enterOTP;

    if (value.length < 6) {
      return Strings.enterValidOTP;
    }

    return null;
  }

  static String validateAccessCode(String value) {
    if (value.isEmpty) return Strings.enterAccessCode;

    if (value.length < 6) {
      return Strings.enterValidAccessCode;
    }

    return null;
  }

  static String validateEmptyCheck(String value) {
    if (value.isEmpty) return Strings.emptyMessage;

    return null;
  }
}
