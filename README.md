# Crypto Trading App (main project goals is cypto alert system)

## Overview
Crypto Trading App is a powerful and feature-rich Flutter application designed for crypto enthusiasts. It provides deep analysis of cryptocurrencies, real-time stock alerts, and a trained chatbot for trading insights. The app ensures secure authentication and seamless data storage using Firebase while maintaining a beautiful and responsive UI.

## Features
- **Deep Crypto Analysis**: Utilizes CoinGecko API to fetch data for numerous cryptocurrencies, including price trends, market caps, and historical data.
- **Stock Alert System**: Uses Coinbase API to provide real-time stock and price alerts.
- **Secure Authentication**: Implements Firebase Authentication for secure user login and registration.
- **Data Storage**: Firebase Firestore is used for storing user preferences, trading history, and alerts.
- **Trained Chatbot**: Integrated with GPT API to assist users with market insights and trading queries.
- **Beautiful and Responsive UI**: Designed with a clean and modern interface, optimized for various screen sizes.
- - **Firebase cloud messaging is also used**:

## Tech Stack
- **Frontend**: Flutter (Dart)
- **APIs**: CoinGecko API, Coinbase API, OpenAI GPT API
- **Backend & Storage**: Firebase Authentication & Firestore
- **State Management**: Provider / Riverpod (as per implementation)

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/crypto-trading-app.git
   cd crypto-trading-app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Set up Firebase:
   - Create a Firebase project.
   - Enable Firestore and Authentication.
   - Download the `google-services.json` file and place it in `android/app/`.
4. Configure APIs:
   - Obtain API keys from CoinGecko, Coinbase, and OpenAI.
   - Add them to your environment variables or Flutter's `secrets.dart` file.
5. Run the app:
   ```sh
   flutter run
   ```


## Contact
For any queries or contributions, feel free to reach out at [kashif.techdev@gmail.com] or visit the [GitHub repository](https://github.com/your-repo/crypto-trading-app).


