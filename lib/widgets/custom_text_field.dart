import 'package:flutter/material.dart';
import 'package:schoolar_app/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.icon,
      this.onPressed,
      this.type,
      required this.label,
      this.onChanged,
      this.validate,
      this.color = Colors.white,
      this.suffixIconButton,
      this.obsecure = false});
  final String? label;
  final TextInputType? type;
  final bool obsecure ;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final Color color;
  final GestureDetector? suffixIconButton;
  final IconData? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      style: const TextStyle(color: Colors.white),
      obscureText: obsecure,
      validator: validate,
      onChanged: onChanged,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: Colors.white,
        ),
        label: Text(
          label!,
          style: TextStyle(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
    );
  }
}
