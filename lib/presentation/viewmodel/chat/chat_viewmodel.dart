import 'package:flutter_learn/application/router/app_router.gr.dart';
import 'package:flutter_learn/data/model/chat_model.dart';
import 'package:flutter_learn/infrastructure/services/navigation_service.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_viewstate.dart';
import 'package:flutter_learn/presentation/viewmodel/view_model.dart';

class ChatViewModel extends ViewModel<ChatViewState> {
  ChatViewModel() : super(const ChatViewState());

  void init() {
    final List<ChatModel> chatList = [
      ChatModel(
        id: 1,
        name: 'Aravinth Raja',
        message: 'Hey! How’s your project going?',
        isSelect: true,
        isSawMessage: false,
        profileImage: 'assets/images/image2.jfif',
        time: '10:23',
      ),
      ChatModel(
        id: 2,
        name: 'Priya Sharma',
        message: 'Don’t forget the meeting at 3 PM.',
        isSelect: false,
        isSawMessage: true,
        profileImage: 'assets/images/image1.jfif',
        time: '01:00',
      ),
      ChatModel(
        id: 3,
        name: 'John Doe',
        message: 'Can you share the file again?',
        isSelect: true,
        isSawMessage: false,
        profileImage: 'assets/images/image6.jfif',
        time: '09:15',
      ),
      ChatModel(
        id: 4,
        name: 'Emma Watson',
        message: 'I’ll call you later.',
        isSelect: false,
        isSawMessage: true,
        profileImage: 'assets/images/image4.jfif',
        time: '11:42',
      ),
      ChatModel(
        id: 5,
        name: 'Karthik Raj',
        message: 'Let’s catch up this weekend!',
        isSelect: true,
        isSawMessage: false,
        profileImage: 'assets/images/image5.jfif',
        time: '08:30',
      ),
      ChatModel(
        id: 6,
        name: 'Meena Lakshmi',
        message: 'Just finished the new design! 🎨',
        isSelect: true,
        isSawMessage: false,
        profileImage: 'assets/images/image3.jfif',
        time: '06:55',
      ),
    ];

    updateState(state.copyWith(chatList: chatList));
  }

  void setLoading(bool value) {
    updateState(state.copyWith(isLoading: value));
  }

  void setData(String value) {
    updateState(state.copyWith(
      data: value,
      isLoading: false,
      errorMessage: null,
    ));
  }

  void setError(String message) {
    updateState(state.copyWith(
      errorMessage: message,
      isLoading: false,
    ));
  }

  void reset() {
    updateState(const ChatViewState());
  }

  void marksRead({int? id}) {
    if (id == null) return;

    final List<ChatModel> localChatList = (state.chatList ?? []).map((chat) {
      if (chat.id == id) {
        return chat.copyWith(
          isSawMessage: true,
          isSelect: false,
        );
      }
      return chat;
    }).toList();

    updateState(state.copyWith(chatList: localChatList));
    navigateToChatRoom();
  }

  void navigateToChatRoom(){
    NavigationService.push(ChatRoomRoute());
  }

}
