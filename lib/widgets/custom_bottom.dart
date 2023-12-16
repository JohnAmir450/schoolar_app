
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButtom extends StatelessWidget {
   const CustomButtom({
    super.key,required this.text,this.ontap
  });
final String text;
final VoidCallback? ontap;
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
