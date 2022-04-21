import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tapButton(
{
 VoidCallback? tap,
  bool status = false,
  String? text = "Save",
  bool? isValid = false,
  BuildContext? context
}
){
  return GestureDetector(
    onTap: status == true ? null : tap,
    child:  Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: status == false
            ? Colors.green
            : Colors.grey,
        borderRadius: BorderRadius.circular(25)
      ),
      width: MediaQuery.of(context!).size.width,
      child: Text(
        status == false ? text! : 'Please wait...',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );

}