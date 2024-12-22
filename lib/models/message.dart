

class Message {
  final String senderID;
  final String senderemail;
  final String receiverID;
  final String message;
  final String timestamp;

  Message({
    required this.senderID,
    required this.senderemail,
    required this.message,
    required this.timestamp,
    required this.receiverID,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderemail': senderemail,
      'receiverID': receiverID,
      'timestamp': timestamp,
    };
  }
}
