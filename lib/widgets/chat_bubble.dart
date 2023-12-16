import 'package:flutter/material.dart';
import 'package:schoolar_app/models/messages_model.dart';


class ChatBubble extends StatelessWidget {
   ChatBubble({
    super.key,this.radius,this.color,required this.message, required this.alignment
  });
final Message message;
  BorderRadiusGeometry? radius;
  Color? color;
  AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 8),
        padding: const EdgeInsets.all(18),
        decoration:  BoxDecoration(
          color: color,
          borderRadius: radius,),
        child:  Text(
          message.message,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
