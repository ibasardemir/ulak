import 'package:flutter/material.dart';
import 'package:ulak/components/auth/fixed_button.dart';
import 'package:ulak/pages/messages/messages_detail_page.dart';

class MessagesMainPage extends StatefulWidget {
  const MessagesMainPage({super.key});

  @override
  State<MessagesMainPage> createState() => _MessagesMainPageState();
}

class ChatUsers {
  String name;
  String messagename;
  bool isUserAvailable;
  String time;
  ChatUsers(
      {required this.name,
      required this.messagename,
      required this.isUserAvailable,
      required this.time});
}

List<ChatUsers> chatUsers = [
  ChatUsers(
      name: "Zeynebimmmm",
      messagename: "I need some food",
      isUserAvailable: true,
      time: "21 Jan"),
  ChatUsers(
      name: "Umut Paşa",
      messagename: "Yardım lazım bana",
      isUserAvailable: false,
      time: "9 July"),
  ChatUsers(
      name: "Başar Brother",
      messagename: "Müsait misiniz?",
      isUserAvailable: true,
      time: "31 Mar"),
  ChatUsers(
      name: "Boss Aksel",
      messagename: "Lütfen yanıma gelin beyler",
      isUserAvailable: true,
      time: "28 Mar"),
  ChatUsers(
      name: "Suna Teyze",
      messagename: "Acil b5 apartmanı önone gelebilir misiniz?",
      isUserAvailable: true,
      time: "23 Mar"),
  ChatUsers(
      name: "Arrrrrman",
      messagename: "Ben Arrrrman",
      isUserAvailable: true,
      time: "17 Mar"),
  ChatUsers(
      name: "Eren 12",
      messagename: "Abi yardım edebilir misin?",
      isUserAvailable: true,
      time: "24 Feb"),
  ChatUsers(
      name: "Sinan Engin",
      messagename: "?",
      isUserAvailable: false,
      time: "18 Feb"),
];

class _MessagesMainPageState extends State<MessagesMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top:8.0,left: 8.0),
          child: Center(
            child: Container(
              width: 32, // Container genişliği
              height: 32, // Container yüksekliği
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFFF8C00), // Çerçeve rengi
                  width: 4, // Çerçeve kalınlığı
                ),
              ),
              child: InkWell(
                onTap: () {
                  print("Menü butonuna tıklandı.");
                },
                child: const Center(
                  child: Icon(Icons.more_horiz,
                      color: Color(0xFFFF8C00), size: 24), // Icon boyutu
                ),
              ),
            ),
          ),
        ),
        actions: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Conversations",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 247, 215, 176),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Color(0xFFFF8C00),
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Add New",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 249, 248, 248),
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MessagesList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messagename,
                  isUserAvailable: chatUsers[index].isUserAvailable,
                  time: chatUsers[index].time,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MessagesList extends StatefulWidget {
  String name;
  String messageText;
  String time;
  bool isUserAvailable;

  MessagesList(
      {required this.name,
      required this.isUserAvailable,
      required this.time,
      required this.messageText});

  @override
  // ignore: library_private_types_in_public_api
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage(receiver: widget.name,);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isUserAvailable
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.isUserAvailable
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                const SizedBox(height: 8),
                widget.isUserAvailable ? Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFF8C00), shape: BoxShape.circle)) : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
