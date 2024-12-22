
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/models/message.dart';

class ChatService {
  //get instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream

/*
List <map <string, dynamic>[
{
'email':test@gmail.com
'id': ..
},
{
'email':angelasoila06@gmail
'id': ..
},
]
*/

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((Snapshot) {
      return Snapshot.docs.map((doc) {
//go through each individual user
        final user = doc.data();

//return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create new message
    Message newMessage = message(
      senderID: currentUserID,
      senderemail: currentUserEmail,
      receiverID: receiverID,
      timestamp: timestamp,
    );

    //create a chatroom ID for the two users (ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids (ensures the chatroom id is the same for 2 people)
    String chatroomID = ids.join("_");

    //add new message to database
    await _firestore
        .collection("chat_room")
        .doc(chatroomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userID, otheruserID) {
    //CONSTRUCT A CHATROOM FOR 2 USERS
    List<String> ids = [userID, otheruserID];
    ids.sort();
    String chatroomID = ids.join("_");

    return _firestore
        .collection("chat_room")
        .doc(chatroomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
