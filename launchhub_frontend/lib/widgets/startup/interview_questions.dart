import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';

class InterviewQuestions extends StatelessWidget {
  const InterviewQuestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 45, 32, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '40 Interview Questions',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
              ),
              IconButton(
                onPressed: () async {
                  await openLink(context, 'URL_GOES_HERE');
                },
                icon: const Icon(Icons.download_rounded),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    '1. “What was a really thoughtful gift (birthday, anniversary, wedding whatever) you bought or made for someone?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '2. “Tell me something you are learning right now.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '3. “What obstacles are you still working through?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '4. “How do you spend your time outside work?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '5. “Tell me a joke.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '6. “What is the best thing you have done in the last year?"',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '7. “Would you rather be good at a lot of things or an expert at one thing?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '8. “Do you consider yourself a hardworking person or a smart person?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '9. “What is your superpower?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '10. “When you are online just for fun, what’s interesting to you in terms of content and sites?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '11. “What’s your greatest weakness?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '12. “What is the craziest thing you’ve ever done?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '13. “Why do you want to come work at a startup, as opposed to an established company?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '14. “What gets you excited about the future?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '15. “Is it always better to seek permission or ask forgiveness? Why?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '16. “What do you want to know about our company, our product, our culture or this role?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '17. “What would discourage you from working here?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '18. “Have you worked in a distributed team before? What challenges did you face?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '19. “What aspects of your work environment did you like from your previous job? What didn’t you like?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '20. “Walk me through what you perceive to be the typical 9 AM – 5 PM workday at our company.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '21. “Who are our five biggest competitors?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '22. “Tell me something that interests you about our industry.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '23. “How do you handle criticism and feedback?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '24. “What motivates you in your work?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '25. “Describe a situation where you had to make a difficult decision.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '26. “How do you prioritize your tasks and manage your time effectively?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '27. “Tell me about a time you had to work with a difficult team member. How did you handle it?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '28. “What do you believe is the most important quality of a successful startup team member?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '29. “How do you deal with uncertainty and rapid change in a startup environment?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '30. “What is your approach to problem-solving?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '31. “Tell me about a time you had to adapt to a completely new technology or tool.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '32. “What is your experience with remote work, and how do you stay productive while working remotely?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '33. “How do you handle failure and setbacks?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '34. “Tell me about a project where you took the lead and achieved a successful outcome.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '35. “What is your preferred method of communication and collaboration with team members?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '36. “How do you stay updated on industry trends and advancements?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '37. “Tell me about a time when you had to learn a new skill or technology quickly.”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '38. “What do you believe sets you apart from other candidates for this role?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '39. “How do you handle high-pressure situations and tight deadlines?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '40. “Why do you think you’d be a great fit for our team?”',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
