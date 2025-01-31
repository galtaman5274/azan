import 'package:azan/app/image_bloc/image_bloc.dart';
import 'package:azan/app/main_layout/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/localization.dart';
import 'components/locale_dropdown.dart';

class AppSettingsTab extends StatelessWidget {
  const AppSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.watch<MainBloc>();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.systemLanguage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          LocaleDropdown(),
          const SizedBox(height: 30),
          const Text(
            'Animation Duration (seconds)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Slider(
            value: mainBloc.state.animationDuration.toDouble(),
            min: 1,
            max: 60,
            divisions: 12,
            label: mainBloc.state.animationDuration.toString(),
            onChanged: (value) =>
                mainBloc.add(SetAnimationDurationEvent(value.toInt())),
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text('use my photos for screen saver'),
          ),
          ListTile(
            title: const Text('choose photos'),
            trailing: IconButton(
                onPressed: () {
                  context.read<ImageBloc>().add(PickFolderEvent());
                },
                icon: const Icon(Icons.pan_tool)),
          ),
          ListTile(
            title: const Text('Display screen saver in full screen'),
            trailing: IconButton(
              onPressed: () {
                context.read<ImageBloc>().add(PickFolderEvent());
              },
              icon: Checkbox(
                  value: mainBloc.state.screenSaverFull,
                  onChanged: (value) =>
                      mainBloc.add(ScreenSaverFullEvent(value as bool))),
            ),
          ),
          // Slider(
          //   value: navigator.inactivityTimer?.toDouble() ?? 1,
          //   min: 1,
          //   max: 60,
          //   divisions: 60,
          //   label: navigator.inactivityTimer.toString(),
          //   onChanged: (value) =>

          //       navigator.setInactivityTimer(value.toInt())

          //   ,
          // ),
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: navigator.saveSaverSettings,
          //   child: const Text('Save Settings'),
          // ),
        ],
      ),
    );
  }
}
