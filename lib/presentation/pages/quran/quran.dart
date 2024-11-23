import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azan/app/quran/bloc.dart'; // Import your Bloc file
import 'package:azan/app/quran/events.dart';
import 'package:azan/app/quran/states.dart';
import 'package:provider/provider.dart';

import '../../../app/screen_saver/main_provider.dart';
import '../../../domain/qari.dart';

class QariScreen extends StatelessWidget {
  final String filePath;

  const QariScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qari List'),
      ),
      body: BlocConsumer<QariBloc, QariState>(
        listener: (context, state) {
          if (state is QariError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is QariLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QariLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.qariList.length,
                    itemBuilder: (context, index) {
                      final qari = state.qariList[index];
                      return ListTile(
                        title: Text(qari.name),
                        subtitle: Text(qari.whereFrom),
                        trailing: Image(image: AssetImage(qari.img)),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 40, // Adjust based on your UI
                  right: 20, // Adjust based on your UI
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 30, color: Colors.black),
                    onPressed: () {
                      // Use the provider to navigate back to the home screen
                      Provider.of<NavigationProvider>(context, listen: false)
                          .navigateTo('home');
                    },
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     final updatedQariList = List<Qari>.from(state.qariList);
                //     updatedQariList.add(Qari(name: 'New Qari', whereFrom: '', description: ''));
                //     context.read<QariBloc>().add(SaveQariList(filePath, updatedQariList));
                //   },
                //   child: const Text('Add and Save Qari'),
                // ),
              ],
            );
          } else if (state is QariError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
