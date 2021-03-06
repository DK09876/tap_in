import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/model/chat_model.dart';
import 'package:tapin/wrapper/Wrapper.dart';

import '../../../model/user_model.dart';

class ConversationScreen extends StatefulWidget {
  final String chatroomId;
  ConversationScreen(this.chatroomId);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<ConversationScreen> {
  TextEditingController messageController = TextEditingController();

  Stream? chatMessageStream;

  ScrollController listScrollController = ScrollController();

  String ConvertChatId() {
    String id = widget.chatroomId;
    List<String> ids = id.split("_");
    if (ids[0] == Constants.myName) {
      return ids[1];
    }
    return ids[0];
  }

  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 80),
                  controller: listScrollController,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    chatModel thismodel =
                        chatModel.fromMap(snapshot.data.docs[index].data());
                    return messageTile(thismodel.message,
                        thismodel.sendby == Constants.myName);
                  })
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        'sendby': Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      Wrapper().addConversationMessages(widget.chatroomId, messageMap);
      messageController.text = '';
    }
  }

  @override
  void initState() {
    Wrapper().getConversationMessages(widget.chatroomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ConvertChatId()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 183, 255),
        onPressed: () {
          if (listScrollController.hasClients) {
            final position = listScrollController.position.maxScrollExtent;
            listScrollController.animateTo(
              position,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: Icon(
          Icons.arrow_downward,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Stack(
        children: [
          ChatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color.fromARGB(200, 96, 94, 92),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Message',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(54, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/images/send.png",
                          height: 25,
                          width: 25,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class messageTile extends StatelessWidget {
  final String? message;
  final bool isSendbyMe;
  messageTile(this.message, this.isSendbyMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendbyMe ? 80 : 24, right: isSendbyMe ? 24 : 80),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      alignment: isSendbyMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendbyMe
                    ? [
                        const Color.fromARGB(255, 37, 237, 160),
                        const Color.fromARGB(255, 37, 237, 160)
                      ]
                    : [
                        const Color.fromARGB(255, 255, 183, 255),
                        Color.fromARGB(255, 255, 183, 255)
                      ]),
            borderRadius: isSendbyMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(
          message!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
