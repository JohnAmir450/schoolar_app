
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom({
    super.key,required this.text,this.ontap
  });
String text;
VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child:  Center(child: Text(text,style: const TextStyle(color: primaryColor,fontSize: 25),)),
      ),
    );
  }
}
