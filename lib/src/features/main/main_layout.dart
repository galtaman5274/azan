import 'package:azan/src/features/adhan/adhan_page.dart';
import 'package:azan/src/features/home/home_page.dart';
import 'package:azan/src/features/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'main_provider.dart';
part 'constants.dart';

class ScreenSaver extends StatefulWidget {
  const ScreenSaver({super.key});

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Delay the initialization until the first frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NavigationProvider>(context, listen: false)
          .initScreenSaverController(
              Images.getImages(const Locale('en')), this);
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final screenSaverController = navigationProvider.screenSaverController;

    return GestureDetector(
      onTap: screenSaverController?.resetInactivityTimer, // Reset timer on tap
      onPanUpdate: (_) =>
          screenSaverController?.resetInactivityTimer(), // Reset timer on swipe
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // Display the active screen
              Consumer<NavigationProvider>(
                builder: (context, provider, _) {
                  switch (provider.currentScreen) {
                    case 'settings':
                      return const SettingsPage();
                    case 'adhan':
                      return const AdhanPage();
                    case 'home':
                      return const HomePage();
                    default:
                      return const HomePage();
                  }
                },
              ),
              // Screen Saver Overlay
              Consumer<NavigationProvider>(
                builder: (context, provider, _) {
                  return provider.showScreenSaver
                      ? _buildScreenSaver(screenSaverController)
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenSaver(ScreenSaverController? controller) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: AnimatedBuilder(
              animation: controller!.currentAnimation,
              builder: (context, child) {
                Widget animatedImage = Image.asset(
                  controller.images[controller.currentIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );

                switch (controller.currentAnimationType) {
                  case 'scale':
                    animatedImage = Transform.scale(
                      scale: controller.currentAnimation.value,
                      child: animatedImage,
                    );
                    break;
                  case 'rotation':
                    animatedImage = Transform.rotate(
                      angle: controller.currentAnimation.value,
                      child: animatedImage,
                    );
                    break;
                  case 'fade':
                  default:
                    animatedImage = Opacity(
                      opacity: controller.currentAnimation.value,
                      child: animatedImage,
                    );
                    break;
                }

                return animatedImage;
              },
            ),
          ),
        ),
      ],
    );
  }
}

