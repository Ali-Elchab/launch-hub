import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/providers/messages_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/message_bubble.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.read(messagesProvider).messagesStream,
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!chatSnapshots.hasData) {
          return const Center(
            child: Text('No messages found.'),
          );
        }

        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedMessages = chatSnapshots.data!;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 0,
            right: 0,
          ),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].text;

            if (loadedMessages[index].sender == 'user') {
              return MessageBubble(
                message: chatMessage,
                isMe: true,
              );
            } else if (loadedMessages[index].sender == 'bot') {
              return MessageBubble(
                message: chatMessage,
                isMe: false,
              );
            }
            return null;
          },
        );
      },
    );
  }
}
