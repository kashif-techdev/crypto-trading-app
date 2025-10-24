import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'data/datasources/crypto_api_service.dart';
import 'data/repositories/crypto_repository_impl.dart';
import 'domain/usecases/get_top_coins.dart';
import 'domain/usecases/get_coin_details.dart';
import 'presentation/blocs/crypto_bloc.dart';
import 'presentation/pages/crypto_home_page.dart';

void main() {
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
      home: BlocProvider(
        create: (context) => CryptoBloc(
          getTopCoins: GetTopCoins(
            CryptoRepositoryImpl(CryptoApiService()),
          ),
          getCoinDetails: GetCoinDetails(
            CryptoRepositoryImpl(CryptoApiService()),
          ),
        )..add(LoadTopCoins()),
        child: const CryptoHomePage(),
      ),
    );
  }
}
