import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_4/themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    //lightmode vs darkmode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser 
          ? (isDarkMode? Colors.pink.shade400 : Colors.pink.shade300)
          : (isDarkMode? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
          ? Colors.white
          : (isDarkMode? Colors.white : Colors.black),
          ),
      ),
    );
  }
}
