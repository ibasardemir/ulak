import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/users_all_list_provider.dart';
import 'package:ulak/components/auth/fixed_button.dart';
import 'package:ulak/pages/messages/messages_add_page.dart';
import 'package:ulak/pages/messages/messages_detail_page.dart';

class MessagesMainPage extends StatefulWidget {
  const MessagesMainPage({super.key});

  @override
  State<MessagesMainPage> createState() => _MessagesMainPageState();
}

class ChatUsers {
  String name;
  String? messagename;
  bool isUserAvailable;
  String time;
  ChatUsers(
      {required this.name,
      required this.messagename,
      required this.isUserAvailable,
      required this.time});
}

class _MessagesMainPageState extends State<MessagesMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
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
                onTap: () {},
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
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 247, 215, 176),
                    ),
                    child: GestureDetector(
                      onTap: () => _showBottomSheet(context),
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
            BlocBuilder<UserMessagesBloc, UserMessagesState>(
              builder: (context, state) {
                if (state is UserMessagesUpdated) {
                  return ListView.builder(
                    itemCount: state.userMessages.length, // State içindeki kullanıcı listesi
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessagesList(
                        name: state.userMessages[index].userName ?? "",
                        messageText: state.userMessages[index]
                            .messageText, // `messagename` yerine genel kullanım `messageText` olabilir
                        isUserAvailable: state.userMessages[index].isUserAvailable,
                        time: state.userMessages[index].time,
                      );
                    },
                  );
                } else {
                  return Center(); 
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 570, // Açılır sayfanın yüksekliği
        child: Center(
          child: AddUserForm(),
        ),
      ),
      shape: RoundedRectangleBorder(
        // Kenarları yuvarlak bir şekil vermek için
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true, // İçerik çok uzunsa kaydırmayı etkinleştir
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            receiver: widget.name,
          );
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      width: 60.0, // Dairenin genişliği
                      height: 60.0, // Dairenin yüksekliği
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.yellow
                          ], // Gradient renkleri
                          begin:
                              Alignment.topLeft, // Gradient başlangıç noktası
                          end: Alignment.bottomRight, // Gradient bitiş noktası
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.name[0], // Göstermek istediğiniz harf
                          style: TextStyle(
                            fontSize: 20.0, // Harf boyutu
                            color: Colors.white, // Harf rengi
                          ),
                        ),
                      ),
                    ),
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
                widget.isUserAvailable
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFF8C00), shape: BoxShape.circle))
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
