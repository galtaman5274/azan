import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _controller!.forward();

    _navigateToHome();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      //context.router.replace(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation!,
        child: Center(
          child: Image.asset('assets/images/splash_logo.png'),
        ),
      ),
    );
  }
}

// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         state.map(
//           initial: (_) {},
//           authenticated: (_) =>
//               context.router.replace(SignInRoute()),
//           unauthenticated: (_) =>
//               context.router.replace(SignInRoute()),
//         );
//       },
//       child: _PageWidget(),
//     );
//   }
// }

// class _PageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
