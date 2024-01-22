import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/providers/messages_provider.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/chat_messages.dart';

class AiAssistant extends ConsumerStatefulWidget {
  const AiAssistant({super.key});

  @override
  ConsumerState<AiAssistant> createState() => _AiAssistantState();
}

class _AiAssistantState extends ConsumerState<AiAssistant> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(messagesProvider.notifier).fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    final messagesNotifier = ref.watch(messagesProvider.notifier);
    final provider = ref.read(messagesProvider);
    Widget mainContent = Center(
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
          Text('LaunchPal', style: Theme.of(context).textTheme.headlineMedium!),
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
    );
    if (messagesNotifier.messages.isNotEmpty) {
      mainContent = const ChatMessages();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const CustomAppBar(title: 'AI Assistant', showBackButton: false),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgrounds/auth_bg.png'),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: mainContent, // Your main content here
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: const EdgeInsets.only(bottom: 14),
            child: TextFormField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 48, 48, 48),
                  ), // Your icon
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                labelText: 'Ask me anything...',
                labelStyle: Theme.of(context).textTheme.labelLarge,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
