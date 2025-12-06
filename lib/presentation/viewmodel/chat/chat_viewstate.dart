import 'package:equatable/equatable.dart';
import 'package:flutter_learn/data/model/chat_model.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chatList;

  const ChatLoaded({required this.chatList});

  @override
  List<Object?> get props => [chatList];

  ChatLoaded copyWith({
    List<ChatModel>? chatList,
  }) {
    return ChatLoaded(
      chatList: chatList ?? this.chatList,
    );
  }
}

class ChatError extends ChatState {
  final String errorMessage;

  const ChatError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
