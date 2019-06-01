import 'package:flutter/material.dart';
import 'package:flutterhackathon/theme/theme.dart';

class AppDecorations {
  static InputDecoration input({String label, String error, String hintText}) {
    return InputDecoration(
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.all(20.0),
      hasFloatingPlaceholder: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.secondary,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.secondary,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.red,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.red,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      labelText: label,
      labelStyle: TextStyles.defaultLight,
      hintStyle: TextStyles.defaultLight,
      errorStyle: TextStyles.defaultLight,
      errorText: error,
//      hintText: label ?? hintText,
      hintText: hintText,
    );
  }

  static InputDecoration controls(
      {String label, String error, EdgeInsetsGeometry contentPadding}) {
    return InputDecoration(
      contentPadding: contentPadding ?? EdgeInsets.all(20.0),
      hasFloatingPlaceholder: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.secondary,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.secondary,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.red,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: BorderSide(
          color: AppColors.red,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      labelText: label,
      labelStyle: TextStyles.defaultLight,
      hintStyle: TextStyles.defaultLight,
      errorStyle: TextStyles.defaultLight,
      errorText: error,
    );
  }
}
