import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    this.userImage,
    this.name,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  final bool isFirstInSequence;
  final String? userImage;
  final String? name;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : theme.colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 12,
              ),
              child: Column(
                children: [
                  if (!isMe)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: message))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to clipboard')),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  Text(
                    message,
                    style: TextStyle(
                      height: 1.3,
                      color:
                          isMe ? Colors.black87 : theme.colorScheme.onSecondary,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
