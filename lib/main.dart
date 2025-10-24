import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data/datasources/crypto_api_service.dart';
import 'data/repositories/crypto_repository_impl.dart';
import 'domain/usecases/get_top_coins.dart';
import 'domain/usecases/get_coin_details.dart';
import 'presentation/blocs/crypto_bloc.dart';
import 'presentation/pages/main_screen.dart';
import 'auth/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
    // Initialize with default options for web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDemoKeyForWeb',
        appId: '1:123456789:web:abcdef123456',
        messagingSenderId: '123456789',
        projectId: 'crypto-trading-demo',
        authDomain: 'crypto-trading-demo.firebaseapp.com',
        storageBucket: 'crypto-trading-demo.appspot.com',
      ),
    );
  }
  
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Trading App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E293B),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF0F172A),
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          }
          
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) => CryptoBloc(
                getTopCoins: GetTopCoins(
                  CryptoRepositoryImpl(CryptoApiService()),
                ),
                getCoinDetails: GetCoinDetails(
                  CryptoRepositoryImpl(CryptoApiService()),
                ),
              )..add(LoadTopCoins()),
              child: const MainScreen(),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
