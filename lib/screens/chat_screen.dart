import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolar_app/constants.dart';
import '../models/messages_model.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_page_app_bar.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.email});

  final String email;

  CollectionReference messages =
  FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          };
          return Scaffold(

            backgroundColor: Colors.white,
            appBar: buildChatPageAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [

                      ListView.builder(
                        reverse: true,
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBubble(
                            alignment: Alignment.topLeft,
                            message: messageList[index],
                            radius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32)),
                            color: primaryColor,
                          )
                              : ChatBubble(
                            message: messageList[index],
                            color: Color(0xff006D84),
                            radius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(32)),
                            alignment: Alignment.topRight,
                          );
                        },),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: CircleAvatar(child: GestureDetector(
                                  onTap: () {

                                    _scrollDown();

                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,)),
                                backgroundColor: primaryColor,),
                          )),
                    ],
                  ),


                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      cursorColor: primaryColor,
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({'message': data,
                          'createdAt': DateTime.now(),
                          'id': email

                        });

                        controller.clear();
                        _scrollDown();

                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                              borderSide: BorderSide(color: primaryColor)),
                          hintText: 'Type your message here…',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              messages.add({
                                'message': controller.text,
                                'createdAt': DateTime.now(),
                                'id': email
                              });
                              FocusScope.of(context).unfocus();
                              controller.clear();
                              _scrollDown();
                            },
                            child: Icon(
                              Icons.send_outlined,
                              color: Colors.indigo,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                              borderSide: BorderSide(color: primaryColor)),
                          hoverColor: Colors.black),
                    ))
              ],
            ),
          );
        } else {
          return Container(
            color: primaryColor,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  void _scrollDown() {

    _controller.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    // _controller.jumpTo(_controller.position.maxScrollExtent);

  }
}
