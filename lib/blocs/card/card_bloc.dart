import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vazifa_10/data/model/card_model.dart';
import 'package:vazifa_10/data/repositories/card_repository.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardLoading()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<UpdateCard>(_onUpdateCard);
    on<DeleteCard>(_onDeleteCard);
  }

  void _onLoadCards(LoadCards event, Emitter<CardState> emit) async {
    try {
      final cards = await cardRepository.fetchCards(event.userId);
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onAddCard(AddCard event, Emitter<CardState> emit) async {
    try {
      await cardRepository.addCard(event.card);
      add(LoadCards(event.card.userId));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onUpdateCard(UpdateCard event, Emitter<CardState> emit) async {
    try {
      await cardRepository.updateCard(event.card);
      add(LoadCards(event.card.userId));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onDeleteCard(DeleteCard event, Emitter<CardState> emit) async {
    try {
      await cardRepository.deleteCard(event.cardId);
      // userId'ni yangilash kerak
      final userId = ''; // userId-ni olish usuli kerak
      add(LoadCards(userId));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }
}
