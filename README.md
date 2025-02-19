# Emergency SOS App for ABU Zaria

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Technical Setup](#technical-setup)
- [Installation Guide](#installation-guide)
- [Usage](#usage)
- [Future Features](#future-features)
- [Contributing](#contributing)
- [License](#license)

## Introduction
The **Emergency SOS App for ABU Zaria** is a mobile application designed to enhance campus security and provide students, staff, and visitors with a reliable way to quickly alert authorities and contacts during emergencies. The app supports real-time location sharing, audio/video recording, and anonymous reporting to foster a safer campus environment.

## Features

### Core Features
- **SOS Button:** One-tap emergency alert system.
- **Add New Contact:** Easily add trusted contacts for emergency alerts.
- **Update/Delete Contact:** Modify or remove existing emergency contacts.
- **Display All Contacts:** View a list of all configured emergency contacts.
- **Language Selection:** Choose your preferred language for the app interface.
- **Auto Send Emergency on Voice Detection:** Automatically trigger an emergency alert when specific distress keywords are detected.
- **Emergency Tips and Guide:** Access essential safety tips and guides for different types of emergencies.

### User-Specific Features
- **Student ID Integration:** Seamless registration using ABU IDs.
- **Anonymous Reporting:** Report incidents without revealing your identity.
- **Safety Check-In:** Scheduled check-ins trigger alerts if not confirmed.

### Campus Security Features
- **Admin Dashboard:** Monitor alerts and incidents in real time.
- **Geo-Fencing:** Ensure app operation within campus boundaries.
- **Incident Logs:** Track and analyze past incidents.

## Technical Setup

### Development Stack
- **Frontend:** Flutter (supports Android and iOS).
- **Backend:** Node.js and Firebase Firestore.
- **APIs:** Google Maps API for location tracking, Twilio API for SMS alerts.

### Infrastructure
- **Hosting:** Google Firebase.
- **Data Encryption:** End-to-end encryption for user data.

## Installation Guide

### Prerequisites
- Flutter SDK installed
- Firebase account for backend services
- Node.js installed

### Steps to Set Up
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd personal_sos_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase configuration files.
5. Run the app:
   ```bash
   flutter run
   ```

## Usage
1. **Register:** Sign up using your ABU student or staff ID.
2. **Activate SOS:** Tap the SOS button in case of an emergency.
3. **Select Emergency Type:** Choose the appropriate category.
4. **Location Sharing:** Enable location permissions for real-time tracking.
5. **Incident Reporting:** Submit reports anonymously if needed.
6. **Manage Contacts:** Add, update, delete, or view emergency contacts.
7. **Language Selection:** Choose your preferred language.
8. **Emergency Guide:** Access tips for handling different emergencies.

## Future Features
- **AI-Powered Predictive Analytics:** High-risk area predictions.
- **Voice Activation:** SOS alerts triggered by voice commands.
- **Offline SOS Mode:** Alerts via SMS without internet.
- **Wearable Device Integration:** Smartwatch SOS triggers.
- **Community Support Features:** Peer helpers and volunteer responders.

## Contributing
We welcome contributions! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-name`).
5. Open a Pull Request.

## License
This project is licensed under the [MIT License](LICENSE).

