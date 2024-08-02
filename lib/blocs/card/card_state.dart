part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<CardModel> cards;

  const CardLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

class CardOperationFailure extends CardState {
  final String error;

  const CardOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
