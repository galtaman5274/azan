import 'package:azan/app/locale_provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/url_provider/bloc.dart';
import '../../../../localization/localization.dart';
import '../../widgets/dropdown_builder.dart';

// typedef CallbackSetting = void Function(String, int);

// class MainButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color color;
//   final String text;
//   final double size;
//   const MainButton(
//       {super.key,
//       required this.onPressed,
//       required this.color,
//       required this.text,
//       required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: onPressed,
//       color: color,
//       minWidth: size,
//       child: Text(
//         text,
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

// class SettingsButton extends StatelessWidget {
//   final Color color;
//   final String text;
//   final int value;
//   final String setting;
//   final CallbackSetting callback;
//   const SettingsButton(
//       this.color, this.text, this.value, this.setting, this.callback, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: () => callback(setting, value),
//       color: color,
//       child: Text(text, style: const TextStyle(color: Colors.white)),
//     );
//   }
// }

class LocaleDropdown extends StatelessWidget {
  


   LocaleDropdown({
    super.key
  });
final Map<String, String> lang = {
    'en': 'English',
    'de': 'Deutsch',
    'ar': 'العربية',
    'tr': 'Türkçe',
  };
  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.watch<LocaleCubit>().state;
    return CustomDropdown<Locale>(
      value: selectedLocale,
      items: AppLocalizations.supportedLocales,
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          context.read<LocaleCubit>().setLocale(newLocale);
          final locale = context.read<LocaleCubit>().state.languageCode;
          context.read<ContentBloc>().add(LoadContentList(locale));
        }
      },
      itemBuilder: (context, locale) {
        return Text(lang[locale.toString()] as String); // Build each dropdown item
      },
      hint: "Select a language", // Optional hint text
    );
  }
}
