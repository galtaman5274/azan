// import 'package:auto_route/auto_route.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           InkWell(
//             onTap: () async {},
//             child: UserAccountsDrawerHeader(
//               accountName: CustomText(
//                 text: context.l10n.drawerProfileUserName,
//                 textStyle: TextStyles.titleLarge,
//               ),
//               accountEmail: CustomText(
//                 text: context.l10n.sampleEmail,
//                 textStyle: TextStyles.titleMedium,
//               ),
//               currentAccountPicture: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                     Assets.drawerAvatarImg), // Your avatar image here
//               ),
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(Assets
//                       .drawerHeaderBackgroudImg), // Your header background image here
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.category),
//             title: CustomText(
//               text: context.l10n.education,
//               textStyle: TextStyles.labelMedium,
//             ), // Replace with category name
//             onTap: () {
//               context.router.replace(const HomeRoute());
//             },
//           ),
//
//           ListTile(
//             leading: const Icon(Icons.language),
//             title: CustomText(
//               text: context.l10n.changeLanguage,
//               textStyle: TextStyles.labelMedium,
//             ),
//             onTap: () {
//               _showLanguageDialog(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Choose Language'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: AppLocalizations.supportedLocales.map((locale) {
//               return ListTile(
//                 title: Text(locale.languageCode),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _changeLanguage(context, locale);
//                 },
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _changeLanguage(BuildContext context, Locale locale) {
//     AppWidget.of(context)?.setLocale(locale);
//   }
// }
