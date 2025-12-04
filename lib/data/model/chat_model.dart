import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? name;
  final int? id;
  final String? message;
   bool? isSelect;
   bool? isSawMessage;
  final String? profileImage;
  final String? time;

   ChatModel({
    this.name,
    this.id,
    this.message,
    this.isSelect,
    this.isSawMessage,
    this.profileImage,
    this.time,
  });

  ChatModel copyWith({
    String? name,
    int? id,
    String? message,
    bool? isSelect,
    bool? isSawMessage,
    String? profileImage,
    String? time,
  }) {
    return ChatModel(
      name: name ?? this.name,
      id: id ?? this.id,
      message: message ?? this.message,
      isSelect: isSelect ?? this.isSelect,
      isSawMessage: isSawMessage ?? this.isSawMessage,
      profileImage: profileImage ?? this.profileImage,
      time: time ?? this.time,
    );
  }
}



class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final Timestamp timestamp;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }

  factory ChatMessage.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      text: data['text'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isRead: data['isRead'] ?? false,
    );
  }
}
