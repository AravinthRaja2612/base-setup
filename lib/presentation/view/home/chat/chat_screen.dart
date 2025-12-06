import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learn/presentation/view/home/chat/chat_view.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_viewmodel.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit()..init(),
      child: const ChatScreenView(),
    );
  }
}
