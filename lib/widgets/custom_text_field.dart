import 'package:flutter/material.dart';
import 'package:schoolar_app/constants.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,
this.type, required this.label,this.onChanged,this.validate,this.color=Colors.white,this.suffixIconButton
  ,this.obsecure=false});
 String? label;
 TextInputType? type;
 bool obsecure=false;
 String? Function(String?)? validate;
 Function (String)? onChanged;
 Color color;
   GestureDetector? suffixIconButton;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor:primaryColor ,
      style: TextStyle(color: Colors.white),
      obscureText: obsecure,
      validator:validate,
      onChanged: onChanged,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: suffixIconButton,
        label:Text(label!,style:  TextStyle(color: color),),
        enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: color),

          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        border: OutlineInputBorder(borderSide:  BorderSide(color: color),

          borderRadius: BorderRadius.circular(
            8,

          ),
        ),
        focusedBorder:  OutlineInputBorder(borderSide:  BorderSide(color: color),

      borderRadius: BorderRadius.circular(
        8,

      ),
    ),
      ),
    );
  }
}