
# Flutter Firebase Messaging App

This Flutter application is a simple messaging app that allows users to send and receive messages. It utilizes Firebase for backend services such as user authentication and message storage.

## Features

- User authentication: Users can log in using their email and password or create a new account.
- Real-time messaging: Once logged in, users can send and receive messages to/from other registered users.
- Firebase Firestore: Messages are stored in Firestore, ensuring real-time synchronization across devices.
- Flutter UI: The app has a clean and intuitive user interface built using Flutter widgets.

## Getting Started

To run this application locally or on your device, follow these steps:

### Prerequisites

- Flutter SDK installed on your machine
- Firebase account and a project created on Firebase Console
- Firebase configuration added to the Flutter project

# Firebase Setup

 - Go to Firebase Console and create a new project if you haven't already.

 - Set up Firebase Authentication and Firestore for your project.

 - Download the Firebase configuration files (google-services.json for Android and GoogleService-Info.plist for iOS) and add them to your Flutter project.

 - Update the necessary Firebase configurations in the Flutter project to establish a connection with Firebase services.

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/your-repo.git

2. Navigate to the project directory:
   ```bash
   cd (file you cloned)/chat-app
   
3. Run the following command to get the required dependencies:
   (be aware that you need to install the firebase first);
    ```bash
    flutter pub get firebase_auth
    flutter pub get firebase_core
    flutter pub get cloud_firestore
   
4. Add Firebase configuration files to the android/app and ios/Runner directories based on Firebase Console instructions.


6. Run the app on a connected device or simulator:
    ```bash
    flutter run

# Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/new-feature).
3. Make your changes and commit them (git commit -am 'Add new feature').
4. Push to the branch (git push origin feature/new-feature).
5. Create a new Pull Request.

# Acknowledgements
- Flutter
- Firebase
- FlutterFire

Contact
For any questions or inquiries, feel free to contact [yeast1242@email.com].

## Happy Messaging! 🚀
