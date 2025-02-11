/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/components/chat_bubble.dart';
import 'package:flutter_application_4/components/my_textfield.dart';
import '../services/auth/auth_service.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

   ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

@override
  State <ChatPage> createState()=> _ChatPageState();
  }
  class ChatPageState extends State <ChatPage>{
 
  }
  //text controller
  final TextEditingController _messageController = TextEditingController();

//chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for textfield focus
 FocusNode myfocusNode = FocusNode();

@override
void initState(){
  super.initState();

  //add a listener to the focus mode
  myfocusNode.addListener(() {
    if (myfocusNode.hasFocus) {
      //cause a delay so that the keyboard has time to show up
      //then the amount of remaining space will be calculated
      //then scroll down
      Future.delayed(const Duration(milliseconds: 500), () =>scrollDown()
      );
    }
  });

  //wait a bit for listview to be built, then scroll to bottom
  Future.delayed(const Duration(milliseconds: 500), () =>scrollDown()
  );
}

@override 
void dispose(){
  myfocusNode.dispose();
  _messageController.dispose();
  super.dispose();
}

//scroll controller
final ScrollController _scrollController = ScrollController();
void scrollDown (){
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}

//send message
  Future<void> sendMessage() async {
    //if there's something inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(widget.receiverID, _messageController.text );

      //clear text controller
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:  Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
        body: Column(
          children: [
            //display all messages
            Expanded(
              child: _buildMessageList(),
              ),

              //user input
            _buildUserInput(),
          ],
        )
      );
  }

  //build message list
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID), 
      builder: (context, snapshot){
      //errors
      if (snapshot.hasError) {
        return const Text('Error');
      }

      //loading
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading');
      }

      //return list view
      return ListView(
        controller: _scrollController,
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      );
      });
  }
  
  //build message item
  Widget _buildMessageItem (DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map <String, dynamic>;


  //is current user
bool isCurrentUser = data ['senderID'] == _authService.getCurrentUser ()!.uid;

  //align messages to the right if the sender is current user, otherwise left
var alignment = isCurrentUser? Alignment.centerRight: Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end: CrossAxisAlignment.start,
    children: [
      ChatBubble(message: data ["message"], isCurrentUser: isCurrentUser),]
      ),
    );
  }


  //build message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
      children: [
    //text field should take up most of the space
    Expanded(child: MyTextField(
      hintText: "Type a message", 
      obscureText: false, 
      focusNode: myfocusNode,
      controller: _messageController
      ),
      ),

      //send button
      Container(
        decoration: BoxDecoration(
          color: Colors.pink[400],
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.only(right: 25),
      child: IconButton(
        onPressed: sendMessage, 
        icon: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
          ),
        )
      ),
      ],
      ),
    );
  }*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/components/chat_bubble.dart';
import 'package:flutter_application_4/components/my_textfield.dart';
import '../services/auth/auth_service.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Text controller for message input
  final TextEditingController _messageController = TextEditingController();

  // Chat and authentication services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Focus node for detecting text field focus
  final FocusNode myfocusNode = FocusNode();

  // Scroll controller for automatically scrolling down
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add listener to focus node
    myfocusNode.addListener(() {
      if (myfocusNode.hasFocus) {
        // Delay scrolling down to allow keyboard to appear
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    // Scroll down after a short delay
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myfocusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll down
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // Function to send a message
  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverEmail), // Fixed "Widget" to "widget"
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(child: _buildMessageList()),

          // User input field
          _buildUserInput(),
        ],
      ),
    );
  }

  // Function to build the list of messages
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // Error handling
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading messages'));
        }

        // Show loading indicator while waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Return list view with messages
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // Function to build each message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the message is from the current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // Align messages based on sender
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  // Function to build user input field
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // Text field for user input
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              focusNode: myfocusNode,
              controller: _messageController,
            ),
          ),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[400],
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () async => sendMessage(), // Fixed: added async call
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
