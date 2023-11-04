
import 'package:flutter/material.dart';
import 'package:schoolar_app/screens/login_page.dart';
import '../constants.dart';

AppBar buildChatPageAppBar(context) {
  return AppBar(
    actions: [GestureDetector(
        onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
        child: const Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Icon(Icons.logout),
        ))],
    automaticallyImplyLeading: false,
    backgroundColor: primaryColor,
    centerTitle: true,
    title: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(image: AssetImage('assets/scholar.png'),height: 60,),
        Text('Chat'),
      ],),
  );
}