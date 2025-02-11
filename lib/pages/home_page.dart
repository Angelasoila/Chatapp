import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/chat/chat_service.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';
import 'package:flutter_application_4/components/user_title.dart';
import 'package:flutter_application_4/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  //CHAT AND AUTH SERVICES
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //logout button
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Has Error!");
          }

          //loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          //return list vow
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual list style for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTitle(
        text: userData["email"],
        onTap: () {
          //go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
