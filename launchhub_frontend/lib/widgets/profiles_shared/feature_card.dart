import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, width: 80),
            const SizedBox(
                width: 16), // For spacing between the icon and the text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Adjust font size as needed
                    ),
                  ),
                  const SizedBox(
                      height: 8), // For spacing between title and description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14, // Adjust font size as needed
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
