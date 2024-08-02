import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vazifa_10/data/repositories/user_repositories.dart';
import 'dart:io';

import 'package:vazifa_10/data/model/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUser>(_onAddUser);
    on<EditUser>(_onEditUser);
    // on<TransferMoney>(_onTransferMoney);
  }

  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      final usersStream = userRepository.getUsers();
      await for (var users in usersStream) {
        emit(UsersLoaded(users));
      }
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void _onAddUser(AddUser event, Emitter<UserState> emit) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('No user logged in');

      final userModel = UserModel(
        id: currentUser.uid,
        fullName: event.fullName,
        email: event.email,
        passportId: event.passportId,
        cards: [],
        firstname: event.firstname,
        lastname: event.lastname,
        imageUrl: event.imageUrl,
      );

      await userRepository.addUser(userModel);
      add(LoadUsers());
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void _onEditUser(EditUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.editUser(event.user);
      add(LoadUsers());
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  // void _onTransferMoney(TransferMoney event, Emitter<UserState> emit) async {
  //   try {
  //     await userRepository.transferMoney(
  //         event.fromCardId, event.toCardId, event.amount);
  //     add(LoadUsers());
  //   } catch (e) {
  //     emit(UserOperationFailure(e.toString()));
  //   }
  // }
}
