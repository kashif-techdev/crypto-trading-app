import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/crypto_coin.dart';
import '../../domain/usecases/get_top_coins.dart';
import '../../domain/usecases/get_coin_details.dart';

// Events
abstract class CryptoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTopCoins extends CryptoEvent {
  final int limit;

  LoadTopCoins({this.limit = 20});

  @override
  List<Object?> get props => [limit];
}

class LoadCoinDetails extends CryptoEvent {
  final String coinId;

  LoadCoinDetails(this.coinId);

  @override
  List<Object?> get props => [coinId];
}

// States
abstract class CryptoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class TopCoinsLoaded extends CryptoState {
  final List<CryptoCoin> coins;

  TopCoinsLoaded(this.coins);

  @override
  List<Object?> get props => [coins];
}

class CoinDetailsLoaded extends CryptoState {
  final CryptoCoin coin;

  CoinDetailsLoaded(this.coin);

  @override
  List<Object?> get props => [coin];
}

class CryptoError extends CryptoState {
  final String message;

  CryptoError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final GetTopCoins getTopCoins;
  final GetCoinDetails getCoinDetails;

  CryptoBloc({
    required this.getTopCoins,
    required this.getCoinDetails,
  }) : super(CryptoInitial()) {
    on<LoadTopCoins>(_onLoadTopCoins);
    on<LoadCoinDetails>(_onLoadCoinDetails);
  }

  Future<void> _onLoadTopCoins(LoadTopCoins event, Emitter<CryptoState> emit) async {
    emit(CryptoLoading());
    try {
      final coins = await getTopCoins(limit: event.limit);
      emit(TopCoinsLoaded(coins));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onLoadCoinDetails(LoadCoinDetails event, Emitter<CryptoState> emit) async {
    emit(CryptoLoading());
    try {
      final coin = await getCoinDetails(event.coinId);
      emit(CoinDetailsLoaded(coin));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }
}
