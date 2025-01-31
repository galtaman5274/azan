// import 'package:azan/app/main_layout/bloc.dart';
// import 'package:azan/app/navigation/cubit.dart';
// import 'package:azan/presentation/pages/adhan/adhan_page.dart';
// import 'package:azan/presentation/pages/home/home_page.dart';
// import 'package:azan/presentation/pages/settings/settings_screen.dart';
// import 'package:azan/quran/quran_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'components/screen_saver.dart';

// part 'constants.dart';

// class ScreenSaver extends StatefulWidget {
//   const ScreenSaver({super.key});

//   @override
//   State<ScreenSaver> createState() => _ScreenSaverState();
// }

// class _ScreenSaverState extends State<ScreenSaver>
//     with TickerProviderStateMixin {
//   late AnimationController animationController;
//   // Animation Variables
//   late Animation<double> currentAnimation;
//   Widget mainPage = const HomePage();
//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     );
//     currentAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose(); // Dispose the AnimationController here
//     super.dispose();
//   }

//   void _setRandomAnimation(String currentAnimationType) {
//     if (animationController.isAnimating ||
//         animationController.status == AnimationStatus.completed) {
//       animationController
//           .reset(); // Reset the animation if it's currently running or completed
//     }

//     switch (currentAnimationType) {
//       case 'fade':
//         currentAnimation =
//             Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

//         break;
//       case 'scale':
//         currentAnimation =
//             Tween<double>(begin: 0.5, end: 1.0).animate(animationController);
//         break;
//       case 'rotate':
//         currentAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14)
//             .animate(animationController);
//         break;
//       default:
//         currentAnimation =
//             Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
//     }
//     animationController.forward();
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     final currentPage = context.watch<NavigationCubit>().state;
//     final showScreenSaver = context.watch<MainBloc>().state.showScreenSaver;
//     return GestureDetector(
//       onTap: () => context
//           .read<MainBloc>()
//           .add(ResetInactivityTimerEvent()), // Reset timer on tap
//       onPanUpdate: (_) => context
//           .read<MainBloc>()
//           .add(ResetInactivityTimerEvent()), // Reset timer on swipe
//       child: SafeArea(
//         child: Scaffold(body:
//             BlocBuilder<MainBloc, NavigationState>(builder: (context, state) {
//           _setRandomAnimation(state.currentAnimationType);
//           return Stack(
//             children: [
//               _buildMainPage(currentPage),
//               showScreenSaver
//                   ? MainScreenSaver(
//                       animatedImage: state.images[state.currentIndex],
//                       currentAnimation: currentAnimation,
//                       currentAnimationType: state.currentAnimationType)
//                   : const SizedBox()
//             ],
//           );
//         })),
//       ),
//     );
//   }

//   Widget _buildMainPage(String currentScreen) {
//     switch (currentScreen) {
//       case 'settings':
//         return const SettingsPage();
//       case 'adhan':
//         return const AdhanPage();
//       case 'home':
//         return const HomePage();
//       case 'quran':
//         return const QuranPage();
//       default:
//         return const HomePage();
//     }
//   }
// }
