import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_text.dart';
import 'package:flutter_learn/presentation/viewmodel/chat/chat_viewmodel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel()..init(),
      builder: (context, child) => ChatScreenView(),
    );
  }
}

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatViewModel viewModel = context.watch<ChatViewModel>();

    return Container(
      color:AppColors.surfaceColor(context),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2),
            child: InkWell(
              onTap: (){
                viewModel.marksRead(id: viewModel.state.chatList?[index].id);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                    color: viewModel.state.chatList?[index].isSawMessage == false
                        ? AppColors.backgroundColor(context)
                        : AppColors.surfaceColor(context)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        viewModel.state.chatList?[index].profileImage ?? '',
                      ),
                      radius: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: viewModel.state.chatList?[index].name ?? '',
                            type: TextType.bodyLarge,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                          ),
                          AppTextWidget(
                            text: viewModel.state.chatList?[index].message ?? '',
                            type: TextType.bodyMedium,
                            fontWeight: viewModel.state.chatList?[index].isSawMessage == true && viewModel.state.chatList?[index].isSelect == false ? FontWeight.normal : FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.state.chatList?[index].isSawMessage == false && viewModel.state.chatList?[index].isSelect == true,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor(context)),
                        height: 6,
                        width: 6.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: viewModel.state.chatList?.length??0,
      ),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
