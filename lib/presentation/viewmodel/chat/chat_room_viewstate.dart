import 'package:equatable/equatable.dart';
import 'package:flutter_learn/data/model/chat_model.dart';

class ChatRoomViewState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? data;
  final List<ChatModel>? chatList;

  const ChatRoomViewState({
    this.isLoading = false,
    this.errorMessage,
    this.data,
    this.chatList,
  });

  ChatRoomViewState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? data,
    List<ChatModel>? chatList,
  }) {
    return ChatRoomViewState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      chatList: chatList ?? this.chatList,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data,chatList];
}
