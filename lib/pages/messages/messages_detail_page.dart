import 'package:flutter/material.dart';
import 'package:ulak/pages/messages/messageEntities/message_detail.dart';

class ChatDetailPage extends StatefulWidget{
  final receiver;


  ChatDetailPage({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.receiver,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("Near by",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
  itemCount: messages.length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 10,bottom: 10),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index){
    return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Color(0xFFFF7F50)),
          ),
          padding: EdgeInsets.all(16),
          child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15,),),
        ),
      ),
    );
  },
),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: MessageFormWidget()
            ),
          ),
        ],
      ),
    );
  }
}


class MessageFormWidget extends StatefulWidget {
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
      setState(() {
        messages.add(
        MessageDetail(messageContent: messageText, messageType: "sender")
      );
      });
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