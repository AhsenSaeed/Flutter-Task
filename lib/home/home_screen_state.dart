import 'package:equatable/equatable.dart';
import 'package:fvrt_task/data/meta_data.dart';

class HomeScreenState extends Equatable {
  final DataEvent usersDataEvent;
  final int index;

  const HomeScreenState({required this.index, required this.usersDataEvent});

  const HomeScreenState.initial()
      : this(usersDataEvent: const Loading(), index: 0);

  HomeScreenState copyWith({DataEvent? usersDataEvent, int? index}) =>
      HomeScreenState(
          index: index ?? this.index,
          usersDataEvent: usersDataEvent ?? this.usersDataEvent);

  @override
  List<Object> get props => [index, usersDataEvent];

  @override
  bool get stringify => true;
}
