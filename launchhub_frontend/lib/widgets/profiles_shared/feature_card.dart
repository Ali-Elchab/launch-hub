import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imagePath;
  final Function()? onTap;
  final String? url;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    this.imagePath,
    this.onTap,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 25.0),
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: url == null
                      ? AssetImage(imagePath!) as ImageProvider
                      : NetworkImage(url!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // child: url == null
            //     ? Image.asset(imagePath!, width: 55)
            //     : Image.network(url!, width: 70, height: 100)),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'inter',
                          )),
                  const SizedBox(
                      height: 8), // For spacing between title and description
                  Text(
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 11),
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
