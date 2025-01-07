import 'package:azan/quran/res/app_colors.dart';
import 'package:azan/quran/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'bloc/album_bloc/album_bloc.dart';
import 'bloc/boarding_bloc/boarding_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/player_bloc/player_bloc.dart';
import 'db_helper/db_helper.dart';



class QuranPage extends StatelessWidget {
  const QuranPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BoardingBLoc(pageController: PageController()),
        ),
        BlocProvider(
          create: (_) => HomeBloc(dbHelper: DbHelper()),
        ),
        BlocProvider(
          create: (_) => PlayerBloc(player: AudioPlayer()),
        ),
        BlocProvider(
          create: (_) => AlbumBloc(pageController: PageController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const  HomeView(),
      ),
    );
  }
}
