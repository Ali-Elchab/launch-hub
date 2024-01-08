import 'package:flutter/material.dart';

class StartupCandidateArticle extends StatelessWidget {
  const StartupCandidateArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 58, 16, 16),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 90,
              height: 5,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Choosing The Perfect Candidate For Your Startup',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'In the dynamic and often unpredictable world of startups, the importance of hiring the right candidate cannot be overstated. Unlike established corporations, startups typically operate with leaner teams and resources, making each hire a critical piece of the company\'s puzzle. The right candidate can propel a startup towards unprecedented growth, while a poor choice might set it back significantly.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Understanding the Unique Startup Environment',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'First and foremost, it\'s essential to understand that working in a startup is vastly different from working in a traditional corporate environment. Startups are characterized by a high degree of uncertainty, rapid changes, and the need for adaptability. Therefore, the ideal candidate should not only possess the necessary technical skills but also the mindset to thrive in this volatile environment.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Look for Flexibility and Adaptability',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Candidates who exhibit flexibility and a capacity to adapt are more likely to succeed in a startup. In the early stages, employees might be required to wear multiple hats, dealing with tasks that go beyond their primary job description. This flexibility can be a tremendous asset as the company evolves and new challenges emerge.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Passion and Commitment are Key',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Startups need passionate individuals who are committed to the company’s vision. Unlike a regular 9-to-5 job, startups often require extra hours and an all-hands-on-deck approach during critical periods. Candidates who share the startup\'s vision and demonstrate a willingness to invest their time and energy into making it a reality are invaluable.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Cultural Fit is Crucial',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cultural fit is another crucial aspect of hiring for startups. Since startup teams are usually small, a new hire who doesn\'t fit the company culture can disrupt the team dynamics. It’s important to look for candidates who not only align with the company\'s values and work style but also bring diversity in thought and perspective to the team.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Potential Over Experience',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'While experience is important, potential should not be overlooked. Sometimes, the best candidates are those who bring fresh ideas and perspectives, even if they don\'t have a lengthy resume. Candidates with the ability to learn quickly and who show promise in growing with the company can be just as valuable as experienced professionals.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'In Conclusion',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choosing the perfect candidate for your startup is about finding the right balance of skills, adaptability, passion, cultural fit, and potential. It’s about seeing beyond the resume and understanding how a candidate can grow with your company. Each hiring decision is a step towards shaping the future of your startup, so it\'s essential to give it the careful consideration it deserves.',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
