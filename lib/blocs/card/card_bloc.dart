import 'package:bloc/bloc.dart';
import 'package:vazifa_10/blocs/card/card_event.dart';
import 'package:vazifa_10/blocs/card/card_state.dart';
import 'package:vazifa_10/data/repositories/card_repository.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardLoading()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<UpdateCard>(_onUpdateCard);
    on<DeleteCard>(_onDeleteCard);
    on<TransferMoney>(_onTransferMoney);
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
      final cards = await cardRepository.fetchCards(event.card.userId);
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onUpdateCard(UpdateCard event, Emitter<CardState> emit) async {
    try {
      await cardRepository.updateCard(event.card);
      final cards = await cardRepository.fetchCards(event.card.userId);
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onDeleteCard(DeleteCard event, Emitter<CardState> emit) async {
    try {
      await cardRepository.deleteCard(event.cardId);
      final cards = await cardRepository.fetchCards(event.cardId);
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }

  void _onTransferMoney(TransferMoney event, Emitter<CardState> emit) async {
    try {
      final senderCard =
          await cardRepository.fetchCardByNumber(event.senderCardNumber);
      final recipientCard =
          await cardRepository.fetchCardByNumber(event.recipientCardNumber);

      if (senderCard.balance < event.amount) {
        emit(CardOperationFailure('Insufficient funds'));
        return;
      }

      senderCard.balance -= event.amount;
      recipientCard.balance += event.amount;

      await cardRepository.updateCard(senderCard);
      await cardRepository.updateCard(recipientCard);

      emit(CardLoaded(await cardRepository.fetchCards(event.userId)));
    } catch (e) {
      emit(CardOperationFailure(e.toString()));
    }
  }
}
