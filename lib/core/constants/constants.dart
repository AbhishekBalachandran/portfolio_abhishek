import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConstValues {
  static final String userName = 'Abhishek B Ambady';
  static final String resumeFileId = '1Z6YYSdvS2wEZvLY81M0NrNI3BFd6Gkac';
  static final mountainWallpaper =
      'assets/images/daniel-leone-g30P1zcOzXo-unsplash.jpg';
  static final String rocketIcon = 'assets/images/rocket12.png';

  static final String aboutMeDescription =
      '''I’m a Flutter Developer with 2 years of experience, passionate about building smooth, user-friendly, and impactful applications. I’ve worked on multiple projects for both Android and iOS, from development to successful deployment. I enjoy working in collaborative teams, learning new skills, and taking on challenges that help me grow as a developer. My goal is not just to contribute to mobile apps, but to explore and expand into other areas of technology and make a meaningful impact. ''';

  static final List proclamations = [
    [
      'App Developer',
      FaIcon(FontAwesomeIcons.keyboard, color: Colors.grey.shade500, size: 50),
    ],
    [
      'UX Enthusiast',
      FaIcon(
        FontAwesomeIcons.penToSquare,
        color: Colors.grey.shade500,
        size: 50,
      ),
    ],
    [
      'Football',
      FaIcon(FontAwesomeIcons.futbol, color: Colors.grey.shade500, size: 50),
    ],
  ];

  static final List appbarText = [
    ['About', false],
    ['Passion', false],
    ['Experience', false],
    ['Work', false],
    ['Contact', false],
  ];

  List basicInfo = [
    ['Download CV', false],
    ['Contact Info', false],
  ];

  List aboutMe = [
    ['Experiance', 'Flutter Developer', '2024-Present'],
    ['Education', 'Diploma in CS', '2021-2023'],
  ];

  List skills = [
    ['Flutter', 'Experienced', 'assets/images/icons8-flutter-logo-480.png'],
    ['Dart', 'Experienced', 'assets/images/dart-logo.png'],
    [
      'REST APIs',
      'Experienced',
      'assets/images/rest_api_logo-removebg-preview.png',
    ],
    ['Firebase', 'Experienced', 'assets/images/firebase_logo.png'],
    ['Http', 'Experienced', 'assets/images/dio-logo.png'],
    ['Figma', 'Intermidate', 'assets/images/figma-logo.png'],
    ['Git', 'Experienced', 'assets/images/Git-Icon-1788C (1).png'],
  ];

  List whatIDo = [
    [
      'Development',
      '''I have a strong foundation in mobile app development using Flutter, with experience in publishing apps to both Play Store and App Store. Alongside mobile, I have additional skills in web development and backend, and I’m eager to expand into new areas of technology. My focus is on writing clean, readable, and maintainable code that results in smooth, user-friendly applications that meet client needs.''',
    ],
    [
      'Problem Solving',
      '''I enjoy solving problems ranging from simple to complex, and I often look for opportunities to approach challenges with code. My goal is to deliver efficient solutions within a short time, balancing practicality with scalability. I continuously train and refine these skills through Flutter projects and by exploring different methods of optimization.''',
    ],
    [
      'Collaboration & Growth',
      '''I believe great software is built through collaboration. I work effectively with designers, backend engineers, testers, and product managers in agile environments. Beyond technical contributions, I focus on improving communication, adaptability, and teamwork. At the same time, I’m committed to continuous learning — growing not just as a developer, but as a well-rounded professional ready to explore new technologies and challenges.''',
    ],
  ];

  List projects = [
    [
      'assets/images/parent_portfolio.jpg',
      'School Parent App',
      'A dedicated application for parents to stay connected and informed about their children’s academic journey in real-time. The app provides dynamic access to key details such as homework, library records, attendance, timetables, extracurricular activities, transportation updates, and calendar events. Parents can receive personalized messages and announcements directly from teachers, office admins, or the principal, with all updates delivered instantly through push notifications. The app also offers a comprehensive fee management system, allowing parents to view the full fee structure and make secure payments via the integrated Worldline payment gateway. Multiple student profiles can be managed seamlessly within a single account, making it convenient for parents with more than one child enrolled. Built with a clean UI/UX, smooth animations, RESTful APIs, push notifications, Provider for state management, and structured code architecture, the app ensures both usability and scalability. Deployed successfully on the Play Store.',
    ],
    [
      'assets/images/gold scheme portfolio.jpg',
      'Gold Scheme App',
      'A customer-focused application developed for an organization offering various gold saving schemes. The app enables users to explore and choose saving plans tailored to their investment goals and budget, ensuring access to quality jewellery at preferred destinations. Built with a clean and engaging UI enhanced by smooth animations, it delivers a seamless user experience. Key features include SOAP API integration for secure data fetching, Provider for state management, Hive and Shared Preferences for local storage, and Firebase push notifications for timely updates. Developed using Flutter and deployed on the App Store, the app effectively combines functionality with performance to support customer engagement and trust.',
    ],
    [
      'assets/images/teachers_portfolio.jpg',
      'Teacher\'s App',
      'A comprehensive platform designed exclusively for teachers to efficiently manage and monitor student and classroom-related activities. The app enables teachers to record attendance, update marks, assign and track homework, plan lessons, and manage timetables. Teachers can also access detailed student profiles, including information on parents, siblings, transportation, and fee details, while class teachers gain additional privileges to oversee their class as a whole. Personalized comments and messages can be added for individual students, ensuring better communication and feedback. Beyond student management, the app also helps teachers track their own working days, assignments, leave requests, and school events, along with a dedicated timetable for each teacher. Built with smooth UI/UX, structured architecture, and enhanced usability features such as push notifications, local storage, and state management, the app ensures efficiency and reliability in day-to-day teaching workflows.',
    ],
    [
      'assets/images/hrms_portfolio.jpg',
      'HRMS',
      'A comprehensive human resource management tool designed to streamline and automate HR operations within an organization. The app enables users to manage and monitor key functions such as attendance, shifts, leave, loans, and payroll, while also offering the ability to view and download detailed reports. Developed with a clean and attractive UI/UX enhanced by smooth animations, it ensures an intuitive and engaging user experience. Core features include RESTful API integration, push notifications, Provider for state management, Shared Preferences for local storage, and a structured code architecture that separates logic from UI, ensuring clean, readable, and maintainable code.',
    ],
    [
      'assets/images/sales_executive.jpg',
      'Sales Executive App',
      'A proprietary internal mobile platform designed to enhance the efficiency of an organization’s field sales team. The app enables executives to capture customer information, manage product carts, generate real-time quotations, and retrieve client data on the go. I was responsible for developing core features, implementing a smooth UI/UX with animations, integrating RESTful APIs, and setting up push notifications using Firebase. Built with Flutter, Firebase, Shared Preferences, and Provider for state management, the app followed clean coding standards and scalable architecture. It was successfully deployed as an unlisted application on both the Play Store and App Store, delivering a seamless and optimized user experience.',
    ],
  ];

  static final List socialMediaLinks = [
    [
      'assets/images/icons8-linkedin-logo-60.png',
      'https://www.linkedin.com/in/abhishekbambady/',
    ],
    [
      'assets/images/icons8-github-logo-60.png',
      'https://github.com/AbhishekBalachandran',
    ],
  ];
}
