import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormFiled({
  required String? Function(String?)? validator,
  void Function(String)? onChangedFunction,
  required TextEditingController? controller,
  bool isPassword = false,
  Function(String)? onSubmitted,
  double radius = 5.0,
  required String label,
  required Widget? prefixIcon,
  IconData? suffixIcon,
  required TextInputType? type,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      validator: validator,
      onChanged: onChangedFunction,
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: label,
        prefixIcon: prefixIcon,
        //بعملها علشان اقدر اعمل كليك عليها
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
      ),
    );
void showToast({required String? message, required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: message ?? "",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
Widget defaultButton(
    {double width = double.infinity,
      required void Function()? function,
      required Color color,
      double height = 50.0,
      double radius = 5.0,
      required String text,
      bool isUpperCase = false,
      Color textColor = Colors.white}) =>
    SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: function,
        color: color,
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          isUpperCase == true ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required void Function()? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  //معناها الروتس اللي فاتت عايزها تفضل موجوده ولا لا
      (Route<dynamic> route) => false,
);
