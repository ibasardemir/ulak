import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/database/database.dart';
import 'package:ulak/pages/auth/debug_page.dart';
import 'package:ulak/pages/auth/debug_page_messages.dart';

String mode = "local";

class DebugButton extends StatelessWidget {
  final String name;
  final TextEditingController? userNameController;
  final TextEditingController? phoneNumberController;

  final TextEditingController? senderController;
  final TextEditingController? recieverController;
  final TextEditingController? messageController;

  const DebugButton(
      {super.key,
      required this.name,
      this.userNameController,
      this.phoneNumberController,
      this.senderController,
      this.recieverController,
      this.messageController});

  @override
  Widget build(BuildContext context) {
    
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: containerWidth,
      height: 50.0,
      child: BlocConsumer<MessageDatabaseBloc, MessageDatabaseState>(
        listener: (context, state) {
          if (state is MessageDatabseSuccess) {
            // İşlem başarılı olduğunda yapılacaklar
          } else if (state is MessageDatabseFailure) {
            // Hata durumunda yapılacaklar
            print("Hata: ${state.error}");
          }
        },
        builder: (context, state) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 2,
            ),
            
            onPressed: () async {
              print("pressed");

              switch (mode) {
                case "local":
                  final localDBInstance = LocalDB();
                  if (name == "OpenDB") {
                    print("OpenDB");
                    bool result = await localDBInstance.openDB("test1");
                    
                    if (result) {
                      print("DB opened");
                    } else {
                      print("DB not opened");
                    }

                    print(result);
                  }
                  else if (name == "Save User") {

                    if (localDBInstance.database == null) {
                      print("Open Database First");
                    }
                      else {
                      User user = User(
                          phoneNumber: phoneNumberController?.text,
                          username: userNameController?.text);
                      localDBInstance.saveUser(user);
                      if (phoneNumberController?.text == null ||
                          userNameController?.text == null) {
                        print("null");
                      }
                      if (phoneNumberController?.text == "" ||
                          userNameController?.text == "") {
                        print("empty");
                      }

                      context.read<MessageDatabaseBloc>().add(
                          SaveUserButtonPressed(
                              phoneNumber: phoneNumberController?.text ?? "",
                              username: userNameController?.text ?? ""));
                    }
                  } 
                  else if (name == "Save Message") {
                    if (localDBInstance.database == null) {
                      print("Open Database First");
                    } 
                    else {
                      Message message = Message(
                          sender: senderController?.text,
                          reciever: recieverController?.text,
                          message: messageController?.text,
                          status: false);
                      localDBInstance.saveMessage(message);

                      context.read<MessageDatabaseBloc>().add(
                          SaveMessageButtonPressed(
                              sender: senderController?.text ?? "",
                              reciever: recieverController?.text ?? "",
                              message: messageController?.text ?? "",
                              status: false));
                    }
                  }
                  else if (name == "Get All Users") {
                    if (localDBInstance.database == null) {
                      print("Open Database First");
                    } 
                    else {
                      List<User> users = await localDBInstance.getUsers();

                      for (var user in users) {
                        print(user.phoneNumber);
                        print(user.username);
                        print("------");
                      }
                    }
                  } 
                  else if (name == "Get Messages") {
                    if (localDBInstance.database == null) {
                      print("Open Database First");
                    } 
                    else {
                      print("Get Messages");
                      List<Message> messages =
                          await localDBInstance.getMessages();

                      for (var message in messages) {
                        print(message.sender);
                        print(message.reciever);
                        print(message.message);
                        print(message.status);
                        print(message.sentTime);
                        print(message.id);
                        print("------");
                      }
                    }
                  } 
                  else if (name == "DeleteDB") {
                    localDBInstance.deleteDB("test1");
                    localDBInstance.database = null;
                  } 
                  else if (name == "Go to Messages") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebugPageMessages()));
                  } 
                  else if (name == "Go to Users") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebugPage()));
                  }
                  else if(name=="Sync"){
                    localDBInstance.syncDatabases(FirebaseDB());
                  }
                  break;
                case "firebase":
                  final firebaseDBInstance = FirebaseDB();

                  if(name=="OpenDB"){
                    print("FirebaseDB doesn't implement openDB method");
                  }
                  else if(name=="Save User"){
                    User user = User(
                          phoneNumber: phoneNumberController?.text,
                          username: userNameController?.text);
                    
                    firebaseDBInstance.saveUser(user);
                  
                  }
                  else if(name=="Save Message"){
                    Message message = Message(
                          sender: senderController?.text,
                          reciever: recieverController?.text,
                          message: messageController?.text,
                          status: false);
                    firebaseDBInstance.saveMessage(message);
                  }
                  else if(name=="Get All Users"){
                    List<User> users = await firebaseDBInstance.getUsers();
                    for (var user in users) {
                        print(user.phoneNumber);
                        print(user.username);
                        print("------");
                      }
                  }
                  else if(name=="Get Messages"){
                    List<Message> messages = await firebaseDBInstance.getMessages();
                    
                    for (var message in messages) {
                        print(message.sender);
                        print(message.reciever);
                        print(message.message);
                        print(message.status);
                        print(message.sentTime);
                        print(message.id);
                        print("------");
                      }
                  }
                  else if(name=="DeleteDB"){
                    print("FirebaseDB doesn't implement deleteDB method");
                  }
                  else if(name=="Go to Messages"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebugPageMessages()));
                  }
                  else if(name=="Go to Users"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebugPage()));
                  break;
              }
              else if(name=="Sync"){
                    firebaseDBInstance.syncDatabases(LocalDB());
                  }
            }
            },
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
