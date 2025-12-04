import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_text.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_room_viewmodel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatRoomViewModel()..init(),
      builder: (context, child) => const ChatRoomScreenView(),
    );
  }
}

class ChatRoomScreenView extends StatelessWidget {
  const ChatRoomScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<ChatRoomViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surfaceColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(context),
        elevation: 0.6,
        leadingWidth: 80,
        leading: Row(
          children: [
            BackButton(color: AppColors.primaryColor(context)),
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/image1.jfif'),
              radius: 16,
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: 'John Doe',
              type: TextType.titleMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor(context),
            ),
            AppTextWidget(
              text: 'Online',
              type: TextType.labelSmall,
              color: AppColors.textSecondaryColor(context),
            ),
          ],
        ),
      ),
      body: const ChatScreenBody(receiverId: '123',receiverName: 'Priya Sharma',),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  final String receiverId; // receiver user id
  final String receiverName; // receiver name

  const ChatScreenBody({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatRoomViewModel>();
    final chatId = _getChatId(viewModel.currentUserId, widget.receiverId);

    return Column(
      children: [
        // 🔹 Real-time message stream
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: viewModel.getMessages(chatId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = snapshot.data?.docs ?? [];

              if (messages.isEmpty) {
                return const Center(child: Text("Say Hi 👋"));
              }

              return ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index].data();
                  final isMe =
                      msg['senderId'] == viewModel.currentUserId;

                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      constraints: BoxConstraints(
                        maxWidth:
                        MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? AppColors.primaryColor(context)
                            : AppColors.backgroundColor(context),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: isMe
                              ? const Radius.circular(16)
                              : Radius.zero,
                          bottomRight: isMe
                              ? Radius.zero
                              : const Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: msg['text'] ?? '',
                            type: TextType.bodyMedium,
                            color: isMe
                                ? Colors.white
                                : AppColors.textPrimaryColor(context),
                          ),
                          const SizedBox(height: 4),
                          AppTextWidget(
                            text: _formatTime(msg['timestamp']),
                            type: TextType.labelSmall,
                            color: isMe
                                ? Colors.white70
                                : AppColors.textSecondaryColor(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // 🔹 Message input field
        SafeArea(
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor(context),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: AppColors.surfaceColor(context),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimaryColor(context),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    final text = _messageController.text.trim();
                    if (text.isNotEmpty) {
                      viewModel.sendMessage(
                        receiverId: widget.receiverId,
                        receiverName: widget.receiverName,
                        text: text,
                      );
                      _messageController.clear();
                    }
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primaryColor(context),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getChatId(String user1, String user2) {
    final ids = [user1, user2]..sort();
    return ids.join('_');
  }

  String _formatTime(dynamic ts) {
    if (ts == null) return '';
    final date = (ts as Timestamp).toDate();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }
}


// class _ChatScreenBodyState extends State<ChatScreenBody> {
//   final TextEditingController _messageController = TextEditingController();
//
//   final List<Map<String, dynamic>> _messages = [
//     {'text': 'Hey! How are you doing?', 'isMe': false, 'time': '10:01 AM'},
//     {'text': 'I’m good, thanks! How about you?', 'isMe': true, 'time': '10:02 AM'},
//     {'text': 'Just working on a Flutter project.', 'isMe': false, 'time': '10:03 AM'},
//   ];
//
//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;
//
//     setState(() {
//       _messages.add({
//         'text': text,
//         'isMe': true,
//         'time': _formattedTime(),
//       });
//     });
//     _messageController.clear();
//   }
//
//   String _formattedTime() {
//     final now = TimeOfDay.now();
//     final hour = now.hourOfPeriod.toString().padLeft(2, '0');
//     final minute = now.minute.toString().padLeft(2, '0');
//     final period = now.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$hour:$minute $period';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Chat messages list
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             itemCount: _messages.length,
//             itemBuilder: (context, index) {
//               final msg = _messages[index];
//               final isMe = msg['isMe'] as bool;
//
//               return Align(
//                 alignment:
//                 isMe ? Alignment.centerRight : Alignment.centerLeft,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: 4),
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                   constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width * 0.7,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isMe
//                         ? AppColors.primaryColor(context)
//                         : AppColors.backgroundColor(context),
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(16),
//                       topRight: const Radius.circular(16),
//                       bottomLeft:
//                       isMe ? const Radius.circular(16) : Radius.zero,
//                       bottomRight:
//                       isMe ? Radius.zero : const Radius.circular(16),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: isMe
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                     children: [
//                       AppTextWidget(
//                         text: msg['text'],
//                         type: TextType.bodyMedium,
//                         color: isMe
//                             ? Colors.white
//                             : AppColors.textPrimaryColor(context),
//                       ),
//                       const SizedBox(height: 4),
//                       AppTextWidget(
//                         text: msg['time'],
//                         type: TextType.labelSmall,
//                         color: isMe
//                             ? Colors.white70
//                             : AppColors.textSecondaryColor(context),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//
//         // Message input field
//         SafeArea(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             decoration: BoxDecoration(
//               color: AppColors.backgroundColor(context),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 3,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       filled: true,
//                       fillColor: AppColors.surfaceColor(context),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 10,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: AppColors.textPrimaryColor(context),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 GestureDetector(
//                   onTap: _sendMessage,
//                   child: CircleAvatar(
//                     radius: 24,
//                     backgroundColor: AppColors.primaryColor(context),
//                     child: const Icon(Icons.send, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
