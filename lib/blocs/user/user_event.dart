part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String fullName;
  final String passportId;
  final List cards;
  final String imageUrl;

  AddUser(
    this.firstname,
    this.lastname,
    this.email,
    this.imageUrl,
    this.fullName,
    this.passportId,
    this.cards,
  );

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        email,
        imageUrl,
        fullName,
        passportId,
        cards,
      ];
}

class EditUser extends UserEvent {
  final UserModel user;
  final File? image;

  EditUser(this.user, this.image);

  @override
  List<Object?> get props => [user, image];
}

class TransferMoney extends UserEvent {
  final String fromCardId;
  final String toCardId;
  final double amount;

  TransferMoney(this.fromCardId, this.toCardId, this.amount);

  @override
  List<Object?> get props => [fromCardId, toCardId, amount];
}
