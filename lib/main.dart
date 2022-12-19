import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fvrt_task/home/home_screen.dart';

import 'home/home_screen_bloc.dart';

void main() => runApp(const _App());

class _AppRouter {
  Route _getPageRoute(Widget screen) => Platform.isIOS
      ? CupertinoPageRoute(builder: (_) => screen)
      : MaterialPageRoute(builder: (_) => screen);

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        {
          const screen = HomeScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => HomeScreenBloc(), child: screen));
        }
    }
    return null;
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final appRouter = _AppRouter();
    return MaterialApp(
        title: 'IME',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute);
  }
}
