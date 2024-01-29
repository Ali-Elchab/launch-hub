<img src="./readme/svgs/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/svgs/title2.svg"/>

> A mobile app that fuels startup success by offering essential tools and guidance at every stage.
>
> LaunchHub serves as a centralized hub offering tools and resources for hiring top talent, accessing legal guidance, crafting effective marketing strategies, managing finances, and leveraging AI technologies. Our mission is to support startups by providing a user-friendly platform that simplifies and enhances their business operations.

### User Stories

### Startup

- As a startup, I want recommendations for potential hires based on my startup's needs, so that I can find the best-fit candidates.
- As a startup, I want access to legal resources and templates, so that I can ensure legal compliance and protect my business.
- As a startup, I want access to marketing strategy guides and tools, so that I can develop effective marketing plans to promote my startup's products/services. <br/>

### Job seeker

- As a job seeker, I want to browse job listings, so that I can find opportunities that match my skills and career aspirations.
- As a job seeker, I want to receive notifications about new job openings, so that I can stay updated on relevant opportunities.
- As a job seeker, I want to schedule interviews and track application statuses, so that I can efficiently manage my job application process.

### Admin

- As an admin, I want to have robust control over application settings and configurations so that I can tailor the platform to precisely match the unique needs and preferences of my startup.
- As an admin, I want to access comprehensive usage analytics and insights so that I can make data-driven decisions, optimize user experiences, and identify growth opportunities for the application.
- As an admin, I want the capability to review and moderate job postings and user-generated content so that I can ensure that the content aligns with our platform's policies and maintains a high level of quality and relevance.
  <br><br>

<!-- Tech stack -->
<img src="./readme/svgs/title5.svg"/>

### LaunchHub is built using the following technologies:

- This project employs [Flutter](https://flutter.dev/), a hybrid app development platform, for building Launchhub, an Android mobile app. Flutter's single codebase approach is ideal for cross-platform development. It uses provider for state management.

- For server-side operations, this project leverages [Laravel](https://laravel.com), a PHP framework acclaimed for its implementation of the MVC (Model-View-Controller) architecture. I chose Laravel for its efficient MVC pattern, ensuring organized, maintainable code and streamlined database management.

- For persistent storage (database), the app uses the [MySQL](https://www.mysql.com), a database for storing and manipulating data.

- To send push notifications, the app uses the [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging).

- The app features candidate suggestions to startups and vice versa, using [OpenAI](https://platform.openai.com/docs/introduction) with structured prompts for optimal results.

- For course recommendations, it utilizes the Udemy API, matching courses with user interests.

- In the courses suggestions section, where the app suggests courses for users based on their interesets. I used [Udemy API](https://www.udemy.com/developers/instructor/).

- The admin dashboard is built using [Electron](https://electron-vite.org) and [React](https://react.dev), offering a native desktop app experience. This setup creates a responsive and visually appealing interface, improving project management and efficiency.

<br>

<!-- Prototyping -->
<img src="./readme/svgs/title3.svg"/>

> I designed LaunchHub using wireframes and mockups, iterating on the design until I reached the ideal layout for easy navigation and a seamless user experience.

### Mockup Examples

#### Mobile App

| Home screen                           | Ai Assistance                  | Hire Talent Screen                           |
| ------------------------------------- | ------------------------------ | -------------------------------------------- |
| ![Landing](./readme/mockups/home.png) | ![Ai](./readme/mockups/ai.png) | ![Landing](./readme/mockups/hire-talent.png) |

#### Admin Panel

| Dashboard                                  | User Management                             |
| ------------------------------------------ | ------------------------------------------- |
| ![Landing](./readme/mockups/dashboard.png) | ![Ai](./readme/mockups/user-management.png) |

- Check more Mockups on [Figma](https://www.figma.com/file/s3jSDlC2Y6bQ66UD89vdHp/LaunchHub?type=design&node-id=40%3A951&mode=design&t=loxRXuZyBbfaBCiV-1)

<br><br>

<!-- Database -->
<img src="./readme/svgs/database.svg"/>

> For designing the project's database, I used MySQL Workbench to create and manage the database schema efficiently. Below is my ER Diagram.

<img src="./readme/er-diagram.jpg"/>

<!-- Implementation -->
<img src="./readme/svgs/title4.svg"/>

> Using the wireframes and mockups as a guide, I implemented the LaunchHub app with the following features:

### Startup Screens

| Sign Up Process                             | Home Screen                                    | Contact Advisors                       | Guides & Templates                       |
| ------------------------------------------- | ---------------------------------------------- | -------------------------------------- | ---------------------------------------- |
| ![Landing](./readme/GIFs/signup.gif)        | ![Landing](./readme/GIFs/home.gif)             | ![Landing](./readme/GIFs/advisors.gif) | ![Landing](./readme/GIFs/guides.gif)     |
| Notifications                               | AI Assistant                                   | Job Board                              | Remove Job                               |
| ![Landing](./readme/GIFs/notifications.gif) | ![Landing](./readme/GIFs/ai.gif)               | ![Landing](./readme/GIFs/post-job.gif) | ![Landing](./readme/GIFs/remove-job.gif) |
| Suggested Candidates                        | Contact / Reject Applicants                    | View Job Seeker Profile                | AI Assistant                             |
| ![Landing](./readme/GIFs/suggested.gif)     | ![Landing](./readme/GIFs/reject-applicant.gif) | ![Landing](./readme/GIFs/signup.gif)   | ![Landing](./readme/GIFs/ai.gif)         |

### Job Seeker Screens

| Apply For Job                       | AI Assistant                     | Related Articles & Courses                     | Edit Profile                               |
| ----------------------------------- | -------------------------------- | ---------------------------------------------- | ------------------------------------------ |
| ![Landing](./readme/GIFs/apply.gif) | ![Landing](./readme/GIFs/ai.gif) | ![Landing](./readme/GIFs/related-articles.gif) | ![Landing](./readme/GIFs/edit-profile.gif) |

## Screenshots from the app

### Startup Profile

| Splash Screen                                           | Signup                                                      | Contact Advisors                                   |
| ------------------------------------------------------- | ----------------------------------------------------------- | -------------------------------------------------- |
| ![Landing](./readme/mobile-screenshots/splash.png)      | ![fsdaf](./readme/mobile-screenshots/signup.png)            | ![fsdaf](./readme/mobile-screenshots/advisors.png) |
| Suggested Candidates                                    | Candidates Profile                                          | AI Assistant                                       |
| ![Landing](./readme/mobile-screenshots/hire-talent.png) | ![fsdaf](./readme/mobile-screenshots/candidate-profile.png) | ![fsdaf](./readme/mobile-screenshots/ai.png)       |
| Job Board                                               | Post A Job                                                  | Guides & Templates                                 |
| ![Landing](./readme/mobile-screenshots/job-board.png)   | ![fsdaf](./readme/mobile-screenshots/post-job.png)          | ![fsdaf](./readme/mobile-screenshots/guides.png)   |

### Job Seeker Profile

| Home                                                       | Job Opportunities                                             | Job Post View                                       |
| ---------------------------------------------------------- | ------------------------------------------------------------- | --------------------------------------------------- |
| ![Landing](./readme/mobile-screenshots/jobseeker-home.png) | ![fsdaf](./readme/mobile-screenshots/job-opportunities.png)   | ![fsdaf](./readme/mobile-screenshots/job-post.jpeg) |
| AI Assistant                                               | Edit Profile                                                  |
| ![fsdaf](./readme/mobile-screenshots/initialAI.png)        | ![Landing](./readme/mobile-screenshots/jobseeker-profile.png) |

### Admin Screens (Electron)

| Signin                                      | Dashboard                                             |
| ------------------------------------------- | ----------------------------------------------------- |
| ![Landing](./readme/electron-ss/signin.png) | ![fsdaf](./readme/electron-ss/dashboard.png)          |
| User Management                             | Content Management                                    |
| ![Landing](./readme/electron-ss/users.png)  | ![fsdaf](./readme/electron-ss/content-management.png) |

<br>

<!--Prompt Engineering -->
<img src="./readme/svgs/pormpt.svg">

> In this project, prompt engineering was key to effectively communicate with OpenAI's GPT-4. By carefully crafting questions and instructions, I ensured that the AI provided precise and contextually relevant responses, crucial for the specific objectives and tasks of our work. Below is some prompts used:

Prompt for suggesting potential candidates for startups
<img src="./readme/prompts/prompt2.jpg" />

Prompt for suggesting relative startups to job seekers
<img src="./readme/prompts/prompt1.jpg" />

Prompt for chat assisting startups
<img src="./readme/prompts/prompt3.jpg" />

Prompt for chat assisting job seekers
<img src="./readme/prompts/prompt4.jpg" />
<br>
<img src="./readme/svgs/aws.svg">

> My project takes advantage of AWS's powerful cloud infrastructure for deploying my models. This integration allows us to handle increased traffic and data loads with ease, ensuring high availability and minimal downtime. AWS's tools and services provide the necessary flexibility and efficiency, making our AI solutions more accessible and reliable for users. <a href="./readme/aws-commands.md">Here</a>, you would find the commands used to deploy on Amazon Linux server.
> <br>

<!-- How to run -->
<img src="./readme/svgs/unit-testing.svg"/>

> This project number of unit tests implemented to ensure reliability and accuracy of code belwo are some if the unit tests runned on some of the projects funcitonalities:

<div class='flex row'>
   <img src="./readme/unit-tests/unit-tests1.png">
   <img src="./readme/unit-tests/unit-tests2.png">
   <img src="./readme/unit-tests/unit-tests3.png">
</div>

<br><br>

<!-- How to run -->
<img src="./readme/svgs/title6.svg"/>

> To set up LaunchHub locally, follow these steps:

### Prerequisites

In order to run the mobile app, you should have an android physical phone with [developer mode enabled](https://www.samsung.com/uk/support/mobile-devices/how-do-i-turn-on-the-developer-options-menu-on-my-samsung-galaxy-device/). Or an emulator such as android studio, in order to run your android phone emulator and start the app.

### Installation

_Below is an example of how you can instruct your audience on installing and setting up Launchhub._

### To Start the Laravel Server on LocalHost

1. Install [Composer](https://getcomposer.org/)

   ```sh
   composer install
   ```

2. Rename your '.env.example' file to '.env'
   <br><br>
3. Open your new .env file and make the necessary changes (App name, app key, database name...)
   <br><br>
4. Generate an application key:

   ```sh
   php artisan key:generate
   ```

5. Inside your .env file add the following:

   ```sh
   OPENAI_API_KEY : YOUR-KEY
   UDEMY_CLIENT_ID : YOUR-CLIENT_ID
   UDEMY_CLIENT_SECRET : YOUR-SECRET
   NEWS_API_KEY : YOUR-KEY
   FIREBASE_CREDENTIALS : YOUR-CREDENTIALS
   FIREBASE_SERVER_KEY : YOUR-KEY
   ```

   Here's a reference to get your keys
   [OpenAI Key](https://platform.openai.com/docs/api-reference), [Udemy API](https://www.udemy.com/developers/), [News API](https://newsapi.org), [Firebase](https://firebase.google.com)

6. Get Migrations

   ```sh
   php artisan migrate
   ```

7. Seed Database: You can go to database/seeders/DatabaseSeeder and uncomment the lines you want to seed in the order they are written.

   ```sh
   php artisan db:seed
   ```

#### Mobile App:

1. Install Flutter SDK. Visit [Flutter website](https://docs.flutter.dev/get-started/install)
2. Run Flutter doctor in your terminal
   ```sh
   Flutter doctor
   ```
3. Clone the repository
   ```sh
   git clone https://github.com/Ali-Elchab/launchHub.git
   ```
4. Open the project
   ```sh
   cd launchhub/launchhub_frontend
   ```
5. Get Dependencies
   ```sh
   flutter pub get
   ```
6. Run the App
   ```sh
   flutter run
   ```
   Now, you should be able to run LaunchHub locally and explore its features.

#### Admin Dashboard:

1. Make sure you have Node.js and npm installed on your machine. you can download them from the [Node.js Website](https://nodejs.org/en)
2. Navigate to the electron project
   ```sh
   cd launchhub/admin_portal
   ```
3. Install Dependencied
   ```sh
   npm install
   ```
4. Start the desktop app

   ```sh
   npm run dev
   ```

   Now, you should be able to run LaunchHub Admin Portal locally and explore its features.
