import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/messages_bloc.dart';

class ChatDetailPage extends StatefulWidget {
  final receiver;

  ChatDetailPage({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 249, 249),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                ClipOval(
                  child: Container(
                    width: 50.0, // Dairenin genişliği
                    height: 50.0, // Dairenin yüksekliği
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.yellow
                        ], // Gradient renkleri
                        begin: Alignment.topLeft, // Gradient başlangıç noktası
                        end: Alignment.bottomRight, // Gradient bitiş noktası
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.receiver[0], // Göstermek istediğiniz harf
                        style: TextStyle(
                          fontSize: 30.0, // Harf boyutu
                          color: Colors.white, // Harf rengi
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.receiver,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Near by",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (state is MessagesUpdated) {
                return ListView.builder(
                  itemCount: state.messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (state.messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (state.messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Color(0xFFFF8C00)),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            state.messages[index].messageContent,
                            style: TextStyle(
                              color:(state.messages[index].messageType == "receiver"
                                ? const Color.fromARGB(255, 4, 4, 4)
                                : const Color.fromARGB(255, 255, 255, 255)),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Material(
              elevation: 5.0,
              child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: MessageFormWidget(receiver: widget.receiver,)),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageFormWidget extends StatefulWidget {
  final String receiver;

  MessageFormWidget({required this.receiver});

  @override
  _MessageFormWidgetState createState() => _MessageFormWidgetState();
}

class _MessageFormWidgetState extends State<MessageFormWidget> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String messageText = _messageController.text;

    if (messageText.isNotEmpty) {
      BlocProvider.of<MessagesBloc>(context)
          .add(SentMessages(messageContent: messageText));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15),
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: "Write message...",
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 15),
        FloatingActionButton(
          onPressed: _sendMessage,
          child: Icon(Icons.send, color: Colors.white, size: 18),
          backgroundColor: Color(0xFFFF8C00),
          elevation: 0,
        ),
        SizedBox(width: 2)
      ],
    );
  }
}
