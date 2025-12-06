import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_text.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_viewmodel.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_viewstate.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {

        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChatError) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is ChatLoaded) {
          final chatList = state.chatList;
          final cubit = context.read<ChatCubit>();

          return Container(
            color: AppColors.surfaceColor(context),
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: InkWell(
                    onTap: () => cubit.marksRead(id: chat.id),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: chat.isSawMessage == false
                            ? AppColors.backgroundColor(context)
                            : AppColors.surfaceColor(context),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage(chat.profileImage??""),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                  text: chat.name??'',
                                  type: TextType.bodyLarge,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 1,
                                ),
                                AppTextWidget(
                                  text: chat.message??'',
                                  type: TextType.bodyMedium,
                                  fontWeight: chat.isSawMessage == true
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: chat.isSawMessage == false && chat.isSelect==true,
                            child: Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
