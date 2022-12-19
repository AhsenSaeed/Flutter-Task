import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fvrt_task/backend/server_response.dart';
import 'package:fvrt_task/common/custom_app_bar.dart';
import 'package:fvrt_task/common/error_try_again.dart';
import 'package:fvrt_task/data/meta_data.dart';
import 'package:fvrt_task/home/home_screen_bloc.dart';
import 'package:fvrt_task/home/home_screen_state.dart';
import 'package:fvrt_task/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeScreenBloc>();

    return Scaffold(
        appBar: CustomAppBar(
            leadingWidget: const SizedBox(),
            middleTitleWidget: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                buildWhen: (previous, current) =>
                    previous.index != current.index,
                builder: (_, state) {
                  final indexState = state.index;
                  return Text(
                      indexState == 1 ? AppStrings.FAVOURITE : AppStrings.ALL);
                }),
            trailingWidget: const SizedBox(),
            onPressed: (v) =>
                bloc.updateIndex(v == AppStrings.FAVOURITE ? 1 : 0),
            preferredSizeHeight: kToolbarHeight),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (previous, current) =>
                (previous.usersDataEvent != current.usersDataEvent),
            builder: (_, state) {
              final userEvent = state.usersDataEvent;
              if (userEvent is Error) {
                return Center(
                  child: ErrorTryAgain(
                      margin: const EdgeInsets.all(10),
                      positiveClickListener: () => bloc.getUsers()),
                );
              }
              if (userEvent is Loading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (userEvent is Empty) {
                return Text(userEvent.message);
              }
              if (userEvent is Data) {
                final tempUsers = userEvent.data as List<UserModel>;
                return ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: tempUsers.length,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (_, i) {
                      final user = tempUsers[i];
                      return _SingleUserWidget(
                          user: user,
                          onFavourite: () => bloc.toggleIsFavourite(user.id));
                    });
              }
              return const SizedBox();
            }));
  }
}

class _SingleUserWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onFavourite;

  const _SingleUserWidget({required this.user, required this.onFavourite});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(user.name, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            Text(user.companyName, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            Text(user.email, style: const TextStyle(color: Colors.black))
          ]),
          trailing: IconButton(
              onPressed: onFavourite,
              icon: Icon(
                  user.isFavourite ? Icons.favorite : Icons.favorite_border)))
    ]);
  }
}
