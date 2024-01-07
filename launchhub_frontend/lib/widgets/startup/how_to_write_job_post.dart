import 'package:flutter/material.dart';

class HowToWriteJobPost extends StatelessWidget {
  const HowToWriteJobPost({super.key});

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
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'When you have an open position to fill at your company, you need to get the word out. Job postings are an effective way to advertise an employment opportunity and encourage candidates to apply. Read on to learn how to explore job posting examples and to get a job posting template you can customize for your open position.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'What is a job posting?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The easiest way to understand a job posting is to consider it a job advertisement. A job posting includes a description of the open position your company is offering and enticing details about your company, such as a description of the exciting benefits or perks available to employees.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Steps for writing a job posting',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Follow these steps to craft a job posting that builds the desire to apply in applicants.\n\n'
                    '1. Write the job title with an engaging lead\n'
                    'At the top of a job posting is a lead or heading that provides the job title and catches the attention of job seekers. Start by clearly defining the title of the position and then include up to three of the top perks of the job—for example, paid sick leave, a remote work environment or a mentorship program.\n\n'
                    '2. Introduce your company\n'
                    'Write a brief paragraph that tells your company’s story and outlines any information a potential candidate wants. You might say how many years your company has been in operation, describe your core values and/or discuss your rate of growth.\n\n'
                    '3. Write a brief job description\n'
                    'A job posting isn’t the place for a long paragraph listing the requirements of a role, but you should include two or three features of the position that are likely to attract candidates. For example, you could mention collaborating with a team or developing innovative new technologies.\n\n'
                    '4. Spell out the top benefits\n'
                    'Now, it’s time to delve more deeply into the top benefits of working for your company. List five or six bullet points describing essential reasons why someone should apply for the job.\n\n'
                    '5. Include location details\n'
                    'It’s important to be clear about the location of the job. You can also add a sentence or two to describe why it’s a great place to live and work. Highlight the great schools, call out the affordable cost of living or mention the cultural and/or recreational opportunities in the area. If a job is remote or semi-remote, mention that as well.\n\n'
                    '6. Finish with contact and application information\n'
                    'At the close of your job posting, include a contact email and/or phone number and clearly defined steps for the application process. Ensure interested candidates know what to do next. If possible, hyperlink to your application page.\n\n'
                    '7. Reread, edit and post\n'
                    'The last thing you want is for potential candidates to see a typo or mistake embedded in your job posting. First impressions really do matter, so edit your job posting and have another set of eyes review it before posting.\n\n'
                    'Once you’re satisfied with the copy, you’re ready to post. Indeed makes it easy to post jobs online for free.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tips for writing a job posting',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Here are two tips to help you write a job posting:\n\n'
                    '1. Do your research\n'
                    'To see how your competitors are promoting openings, search the job position you’re hiring for to find similar listings. Identify the strengths and weaknesses of other postings. Incorporate what’s working, and be careful not to make the same mistakes.\n\n'
                    'Also, take the time to find out what employees in similar positions love about their jobs by reading employer reviews posted on websites. Having a good idea of what appeals to candidates can help you decide what to call out in your job posting.\n\n'
                    '2. Talk to your employees\n'
                    'Ask your employees directly what they like about working at your company through face-to-face conversations or an employee satisfaction survey. Not only is your team a great resource for understanding how to improve your internal operations overall, but they can also help you understand what makes your company culture most desirable to new hires.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Job posting template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'For your convenience, we’ve supplied a job posting template and two job posting examples below.\n\n'
                    'Title:\n\n'
                    '[Job title/position name] – [Engaging lead, for example, one to three attractive things about the job]\n\n'
                    'Company intro:\n\n'
                    '[One detailed paragraph detailing your company history, core values, principles and/or diversity and inclusion statement]\n\n'
                    'Job description:\n\n'
                    '[One paragraph including one to three essential requirements of the job position with the option of including salary/hourly rate]\n\n'
                    'Top benefits or perks:\n\n'
                    'As a team member at [Company name], you’ll enjoy:\n\n'
                    '[Bullet list of three to five details that applicants will find most enticing about the job position.] For example:\n\n'
                    'Benefits: Health care, dental or life insurance\n'
                    'Career development: Any opportunities for advancement\n'
                    'Flexible work schedule: Hybrid or work-from-home options or the ability to choose shifts\n\n'
                    'Location:\n\n'
                    '[one to two sentences describing where the job is located and some attractive features of the area]\n\n'
                    'Contact/application information:\n\n'
                    'Include all essential contact information and clear directions on how to apply for the open job position. If you have an application deadline, make sure to also include it here.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Job posting examples',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Example 1\n'
                    'Job title:\n\n'
                    'Entry Level Software Developer—Mentorship program and option to work remotely.\n\n'
                    'Company intro:\n\n'
                    'BestTech is a fast-growing company that relies on emerging technology talent, and we want to give you your first start. BestTech provides all its entry-level software developers with a paid training program to ensure you’ll learn the skills you need to succeed. We offer a flexible schedule and the opportunity to work with some of the industry’s best software developers, either in our Salt Lake City office or remotely across the world. With our wide range of Fortune 500 enterprises as clients, you’ll be working on projects that matter as a part of the BestTech team.\n\n'
                    'Job position description:\n\n'
                    'We’re looking for a full-time entry-level software developer. The ideal candidate is someone who’s just out of school and looking for some quality career experience. Salary is \$35,000 per year with opportunity for advancement, bonuses and paid sick leave. Remote work is possible.\n\n'
                    'Top benefits or perks:\n\n'
                    'As a team member at BestTech, you’ll enjoy:\n'
                    'Mentoring program with some of the most reputable developers in the industry\n'
                    'Comprehensive benefits package, including health, vision and dental insurance\n'
                    'Paid time off\n'
                    'Option to work remotely\n\n'
                    'Location:\n\n'
                    'BestTech HQ is located in Salt Lake City, Utah, the hub of many emerging tech start-ups. Surrounded by stunning mountain views and amazing hiking and camping destinations, Salt Lake is a great place for networking in tech and outdoor activities alike.\n\n'
                    'Contact/application information:\n\n'
                    'To be considered for our summer recruitment round, please submit your application to hr@besttech.com by June 18, 2021. If we accept your application, we’ll be in touch to schedule an interview. We look forward to hearing from you.\n\n'
                    'Example 2\n'
                    'Job title:\n\n'
                    'Warehouse Team Member—\$100 sign-on bonus.\n\n'
                    'Company intro:\n\n'
                    'Best Books Depo’s brick-and-mortar location has been in business for 50 years. Over the last decade, we’ve expanded our business to distribute books across the country, and more than 10,000+ people have relied on Best Books to complete their reading lists. In turn, we rely on a team of talented individuals to deliver the best possible service to each customer. At Best Books, we believe in working together to create a culture where each team member has a voice, so we can continue to grow and improve our operations.\n\n'
                    'Job position description:\n\n'
                    'We’re looking for a committed worker to join our warehouse team that gets book orders ready and shipped out on time to our loyal customers. New team members receive a \$100 sign-on bonus and an \$18 hourly pay rate with an opportunity for advancement.\n\n'
                    'Top benefits or perks:\n\n'
                    'As a team member at Best Books Depo, you’ll enjoy:\n'
                    'Full benefits\n'
                    '15 paid vacation days\n'
                    'Active work environment\n'
                    'Career advancement and bonus opportunities\n\n'
                    'Location:\n\n'
                    'Best Books Depo is located in Tacoma, Washington, and is easily accessible to residents of Seattle by public transit or car. Tacoma offers affordable living, great live music, outdoor activities and a vibrant cultural scene.\n\n'
                    'Contact/application information:\n\n'
                    'If you’re interested, please apply by sending your resume to applications@bestbookdepo.com before June 12, 2021. Thank you for your interest, and we look forward to meeting you.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
