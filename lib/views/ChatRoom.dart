// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bot_task/models/Message.dart';
import 'package:flutter_chat_bot_task/service/Data.dart';
import 'package:flutter_chat_bot_task/views/Star.dart';
import '../MyColors.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  static const route = "/ChatRoom";
  TextEditingController messageEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _needsScroll = false;

  final List<Message> listMessage = [];

  Widget chatMessages() {
    return ListView.builder(
      itemCount: listMessage.length,
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        return MessageTile(
            message: listMessage[index].message,
            sendByMe: listMessage[index].isBot);
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      listMessage.add(Message(
        message: messageEditingController.text,
        isBot: false,
      ));
      String messageBot = Data.getMessageBot(messageEditingController.text);
      listMessage.add(Message(message: messageBot, isBot: true));
      setState(() {
        messageEditingController.text = "";
        _needsScroll = true;
      });
    }
  }

  _scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();
    messageEditingController.addListener(() {
      _needsScroll = true;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollToEnd);
    messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Material(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: color2,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/3.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              const Text('Waled Saied'),
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Image.asset("assets/images/1.png"),
            ),
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                color: color2,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onTap: () {
                        setState(() {
                          _needsScroll = true;
                        });
                      },
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      cursorColor: Colors.white,
                      controller: messageEditingController,
                      decoration: const InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: ()async {
                        // 2 threads

                      await addMessage();


                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Dialogue'),
                            content:
                            const Text('Done, You Send Message To BOT'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Star()));
                                },
                                child: const Text('agreed'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('close'),
                              ),
                            ],
                          ),
                        );
                        
                        // AudioCache player =
                        // AudioCache(prefix: 'assets/sounds/green.wav');
                        // player.play(player);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const MessageTile({Key key, @required this.message, @required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 20, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [color1, color2] : [color1, color2],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }

}
