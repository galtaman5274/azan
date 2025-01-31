import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/navigation/cubit.dart';
import '../../../app/url_provider/bloc.dart';

class QariScreen extends StatelessWidget {
  const QariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qari List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<NavigationCubit>().setPage('home'),
        tooltip: 'Go to Home',
        child: const Icon(Icons.home),
      ),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          if (state is ContentDownloaded) {
            // Fetch the qariList from the Quran data model
            final qariList = state.quranFiles?.qariNameList;
            final qariImageList = state.quranFiles?.qariImageList;

            return ListView.builder(
              itemCount: qariList?.length,
              itemBuilder: (context, index) {
                final qariName = qariList?[index];
                final qariImage = qariImageList?[index];
                return ListTile(
                  title: Text(qariName ?? ''),
                  subtitle: const Text('Egypt'),
                  trailing: Image(
                    image: AssetImage(qariImage ?? ''),
                    width: 100,
                    height: 100,
                  ),
                );
              },
            );
          } else if (state is ContentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContentError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}