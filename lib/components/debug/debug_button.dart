import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/database/database.dart';

class DebugButton extends StatelessWidget {
  final String name;

  DebugButton({required this.name});

  @override
  Widget build(BuildContext context) {
    final localDBInstance = LocalDB();
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Container(
      width: containerWidth,
      height: 50.0,
      child: BlocConsumer<MessageDatabaseBloc, MessageDatabaseState>(
        listener: (context, state) {
          if (state is MessageDatabseSuccess) {
            // İşlem başarılı olduğunda yapılacaklar
            print("Mesajlar başarıyla alındı");
          } else if (state is MessageDatabseFailure) {
            // Hata durumunda yapılacaklar
            print("Hata: ${state.error}");
          }
        },
        builder: (context, state) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFFF8C00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 2,
            ),
            onPressed: () async {
              print("pressed");
              if (name == "OpenDB") {
                print("OpenDB");
                bool result = await localDBInstance.openDB("test");
                /*
                for (int i = 0; i < 10; i++) {
                  User user = User(phoneNumber: "$i", username: "test $i");
                  localDBInstance.saveData("users", user);
                }*/
                
                List<User> users= await localDBInstance.getData("users");

                for (var user in users) {
                  print(user.phoneNumber);
                  print(user.username);
                  print("------");
                }
                print(result);
              } else if (name == "GetMessages") {
                // BLoC olayını tetikle
                context.read<MessageDatabaseBloc>().add(GetMessages());
              }
              else if(name=="Save User"){
                User user = User(phoneNumber: "123", username: "test 123");
                localDBInstance.saveData("users", user);
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
