import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/database/database.dart';

class DebugButton extends StatelessWidget {
  final String name;
  final TextEditingController? userNameController;
  final TextEditingController? phoneNumberController;

  const DebugButton({super.key, required this.name, this.userNameController, this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    final localDBInstance = LocalDB();
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


              if (name == "OpenDB") {
                print("OpenDB");
                bool result = await localDBInstance.openDB("test");
                if(result){
                  print("DB opened");
                }
                else{
                  print("DB not opened");
                }
                
                print(result);
              } else if (name == "GetMessages") {
                // BLoC olayını tetikle
                context.read<MessageDatabaseBloc>().add(GetMessages());
              }
              else if(name=="Save User"){
                if(localDBInstance.database==null){
                  print("Open Database First");
                }
                else{
                   User user = User(phoneNumber: phoneNumberController?.text, username: userNameController?.text);
                localDBInstance.saveData("users", user);
                if(phoneNumberController?.text==null || userNameController?.text==null){
                  print("null");
                }
                if(phoneNumberController?.text=="" || userNameController?.text==""){
                  print("empty");
                }

                context.read<MessageDatabaseBloc>().add(SaveUserButtonPressed(phoneNumber: phoneNumberController?.text??"",username: userNameController?.text??""));

                }
                
               
              }
              else if(name=="Get All Users"){
                if(localDBInstance.database==null){
                  print("Open Database First");
                }
                else{
                 List<User> users= await localDBInstance.getData("users");

                  for (var user in users) {
                    print(user.phoneNumber);
                    print(user.username);
                    print("------");
                  }
                }
              }
              else if(name=="DeleteDB"){
                localDBInstance.deleteDB("test");
                localDBInstance.database=null;
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
