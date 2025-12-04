import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_learn/presentation/viewmodel/chat/chat_room_viewstate.dart';
import 'package:flutter_learn/presentation/viewmodel/view_model.dart';

class ChatRoomViewModel extends ViewModel<ChatRoomViewState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatRoomViewModel() : super(const ChatRoomViewState());



  void init(){
    insertSampleChatData();
}


  Future<void> insertSampleChatData() async {
    final firestore = FirebaseFirestore.instance;

    // 🔹 Replace these with your actual logged-in user's UID
    final userA = FirebaseAuth.instance.currentUser?.uid ?? 'userA123';
    final userB = '123'; // Receiver ID (you used this in your ChatScreen)

    final chatId = [userA, userB]..sort();
    final combinedId = chatId.join('_');

    final chatDoc = firestore.collection('chats').doc(combinedId);

    // Create chat info
    await chatDoc.set({
      'members': [userA, userB],
      'receiverName': 'Raja',
      'receiverImage': 'https://i.pravatar.cc/150?img=3',
      'lastMessage': 'Let’s build the Flutter chat 🚀',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Add some sample messages
    final messages = [
      {
        'senderId': userA,
        'receiverId': userB,
        'text': 'Hey Raja 👋',
        'timestamp': FieldValue.serverTimestamp(),
      },
      {
        'senderId': userB,
        'receiverId': userA,
        'text': 'Hey there! How’s the app coming along?',
        'timestamp': FieldValue.serverTimestamp(),
      },
      {
        'senderId': userA,
        'receiverId': userB,
        'text': 'Almost done! Just testing Firebase chat now 😎',
        'timestamp': FieldValue.serverTimestamp(),
      },
    ];

    for (final msg in messages) {
      await chatDoc.collection('messages').add(msg);
    }

    print('✅ Sample chat inserted successfully.');
  }
  String get currentUserId => _auth.currentUser?.uid ?? '';

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> sendMessage({
    required String receiverId,
    required String receiverName,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;
    final senderId = currentUserId;
    final chatId = _getChatId(senderId, receiverId);

    final message = {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set(message);

    await _firestore.collection('chats').doc(chatId).set({
      'members': [senderId, receiverId],
      'lastMessage': text,
      'updatedAt': FieldValue.serverTimestamp(),
      'receiverName': receiverName,
    }, SetOptions(merge: true));
  }

  String _getChatId(String user1, String user2) {
    final ids = [user1, user2]..sort();
    return ids.join('_');
  }
}
