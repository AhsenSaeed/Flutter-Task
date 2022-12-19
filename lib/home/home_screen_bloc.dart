import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fvrt_task/backend/server_response.dart';
import 'package:fvrt_task/backend/shared_web_service.dart';
import 'package:fvrt_task/data/meta_data.dart';
import 'package:fvrt_task/home/home_screen_state.dart';

class HomeScreenBloc extends Cubit<HomeScreenState> {
  final SharedWebService _sharedWebService = SharedWebService.instance();
  final List<UserModel> _users = <UserModel>[];

  HomeScreenBloc() : super(const HomeScreenState.initial()) {
    getUsers();
  }

  void toggleIsFavourite(int id) {
    final tempState = state.usersDataEvent;
    if (tempState is! Data) return;
    final indexOfUser = _users.indexWhere((element) => element.id == id);
    if(indexOfUser == -1) return;
    final user = _users[indexOfUser];
    user.isFavourite = !user.isFavourite;
    updateIndex(state.index);
  }

  void updateIndex(int index) {
    final isOnFavourite = index == 1;
    final users = isOnFavourite ? _users.where((element) => element.isFavourite) : _users;
    emit(state.copyWith(index: index, usersDataEvent: Data(data: List.of(users))));
  }

  Future<void> getUsers() async {
    emit(state.copyWith(usersDataEvent:const  Loading()));
    try {
      final users = await _sharedWebService.users();
      if (users.isEmpty) {
        emit(state.copyWith(
            usersDataEvent: const Empty(message: 'No users found')));
        return;
      }
      _users.addAll(users);

      emit(state.copyWith(usersDataEvent: Data(data: _users)));
    } catch (_) {
      emit(state.copyWith(usersDataEvent: Error(exception: Exception())));
    }
  }
}
