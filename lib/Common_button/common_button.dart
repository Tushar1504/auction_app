import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  Function()? onPressed;
  double? width;
  String? title;
  CommonButton({Key? key, required this.title, required this.onPressed, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: width ?? 130,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: Colors.indigoAccent),
        child: Center(child: Text('${title}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
      ),
    );
  }
}