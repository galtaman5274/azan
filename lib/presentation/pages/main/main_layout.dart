import 'package:azan/app/main_layout/bloc.dart';
import 'package:azan/app/navigation/cubit.dart';
import 'package:azan/presentation/pages/adhan/adhan_page.dart';
import 'package:azan/presentation/pages/home/home_page.dart';
import 'package:azan/presentation/pages/quran/quran.dart';
import 'package:azan/presentation/pages/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/screen_saver.dart';

part 'constants.dart';

class ScreenSaver extends StatelessWidget {
  const ScreenSaver({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<NavigationCubit>().state;
    final state = context.watch<MainBloc>().state;
    // final locale = context.read<LocaleCubit>().state;
    // context.read<ContentBloc>().add(CheckForLocal(locale.languageCode));
    return GestureDetector(
      onTap: () => context
          .read<MainBloc>()
          .add(ResetInactivityTimerEvent()), // Reset timer on tap
      onPanUpdate: (_) => context
          .read<MainBloc>()
          .add(ResetInactivityTimerEvent()), // Reset timer on swipe
      child: SafeArea(
        child: Scaffold(body:
            Stack(
              children: [
                _buildMainPage(currentPage),
                state.showScreenSaver ? const MainScreenSaver() : const SizedBox()
              ],
            )),
      ),
    );
  }

  Widget _buildMainPage(String currentScreen) {
    switch (currentScreen) {
      case 'settings':
        return const SettingsPage();
      case 'adhan':
        return const AdhanPage();
      case 'home':
        return const HomePage();
      case 'quran':
        return const QariScreen();
      default:
        return const HomePage();
    }
  }
}
