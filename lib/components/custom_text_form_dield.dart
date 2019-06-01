import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/theme/theme.dart';

class AppTextFormField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;
  final String prefixText;
  final String labelText;
  final String initialValue;
  final String prefixIcon;
  final int maxLength;
  final TextInputType keyboardType;
  final bool enabled;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;

  const AppTextFormField({
    Key key,
    this.onSaved,
    this.validator,
    this.hintText = "",
    this.labelText = "",
    this.prefixText,
    this.maxLength,
    this.keyboardType,
    this.enabled = true,
    this.initialValue,
    this.focusNode,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes.s10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (labelText != null)
              ? Text(
                  labelText,
                  style: TextStyles.labelStyle,
                )
              : C0(),
          Row(
            children: <Widget>[
              (prefixIcon != null)
                  ? Image(
                      height: Sizes.s20,
                      image: AssetImage(prefixIcon),
                      color: Colors.red,
                    )
                  : C0(),
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyles.hintText,
                    errorStyle: TextStyles.errorStyle,
                    prefixText: prefixText,
                    errorMaxLines: 1,
                    contentPadding: EdgeInsets.all(
                      Sizes.s5,
                    ),
                  ),
                  inputFormatters: (maxLength != null)
                      ? [
                          LengthLimitingTextInputFormatter(maxLength),
                        ]
                      : [],
                  onSaved: onSaved,
                  onFieldSubmitted: onFieldSubmitted,
                  validator: validator,
                  keyboardType: keyboardType,
                  enabled: enabled,
                  textInputAction: textInputAction,
                  initialValue: initialValue ?? "",
                  style: TextStyles.editText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NonEditableTextField extends StatelessWidget {
  final String hintText;
  final String valueText;
  final String labelText;
  final String icon;
  final Function onTap;
  final EdgeInsetsGeometry padding;

  const NonEditableTextField({
    Key key,
    @required this.hintText,
    @required this.valueText,
    @required this.labelText,
    @required this.icon,
    @required this.onTap,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(Sizes.s10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            labelText.isNotEmpty
                ? Text(
                    labelText,
                    style: TextStyles.labelStyle,
                  )
                : C0(),
            C10(),
            Row(
              children: <Widget>[
                (icon != null)
                    ? Image(
                        height: Sizes.s20,
                        image: AssetImage(icon),
                        color: Colors.red,
                      )
                    : C0(),
                P5(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      valueText.isNotEmpty
                          ? Text(
                              valueText,
                              style: TextStyles.editText,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            )
                          : Text(
                              hintText,
                              style: TextStyles.hintText,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                      labelText.isNotEmpty ? P2() : C0(),
                      labelText.isNotEmpty
                          ? Divider(
                              color: Colors.grey.shade600,
                              height: 2.0,
                            )
                          : C0()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
