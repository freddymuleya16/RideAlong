# RideAlong

Welcome to RideAlong - A Hitchhiking App!

## Overview

RideAlong is a hitchhiking app that connects drivers with passengers heading in the same direction. It aims to make travel more cost-effective, eco-friendly, and social. 

## Features

- **Real-Time Ride Sharing**: Connect with drivers or passengers in real-time.
- **Trip Management**: Easily create, edit, or cancel trips.
- **User Profiles**: Customize your profile and share information with other users.
- **Rating System**: Rate your travel companions and provide feedback.
- **Map Integration**: View trip details and locations on a map.

## Getting Started

Follow these steps to get RideAlong up and running on your local machine.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase Account](https://firebase.google.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/RideAlong.git
   ```

2. Navigate to the project folder:

   ```bash
   cd RideAlong
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase:

   - Create a new Firebase project.
   - Add your Firebase configuration in `lib/config/firebase_config.dart`.

5. Run the app:

   ```bash
   flutter run
   ```

## Configuration

Update the following configurations in `lib/config/app_config.dart`:

```dart
const String appName = 'RideAlong';
const String appVersion = '1.0.0'; 
```

## Contributing

If you'd like to contribute to RideAlong, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature.
3. Make your changes and commit them.
4. Push to your fork and submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
