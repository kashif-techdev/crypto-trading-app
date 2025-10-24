import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/crypto_bloc.dart';
import '../widgets/crypto_coin_card.dart';

class CryptoHomePage extends StatelessWidget {
  const CryptoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Trading',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CryptoBloc>().add(LoadTopCoins());
            },
          ),
        ],
      ),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (state is TopCoinsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CryptoBloc>().add(LoadTopCoins());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.coins.length,
                itemBuilder: (context, index) {
                  final coin = state.coins[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CryptoCoinCard(coin: coin),
                  );
                },
              ),
            );
          } else if (state is CryptoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CryptoBloc>().add(LoadTopCoins());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
