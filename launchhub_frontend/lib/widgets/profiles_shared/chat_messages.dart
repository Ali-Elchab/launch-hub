import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/providers/messages_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/message_bubble.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.read(messagesProvider.notifier).messagesStream,
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (chatSnapshots.data!.isEmpty) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.robot,
                    size: 80,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  const SizedBox(height: 25),
                  Text('LaunchPal',
                      style: Theme.of(context).textTheme.headlineMedium!),
                  const SizedBox(height: 25),
                  Text(
                    'Hi, I\'m LaunchPal, your AI assistant. I\'m here to help you with whatever you need, from answering questions to providing recommendations.\n Let\'s chat!.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Example: Can you provide guidance on creating a business plan for my startup?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
