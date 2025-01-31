// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../app/url_provider/cubit.dart';
// class ContentPage extends StatelessWidget {
//   const ContentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
    

//     return BlocBuilder<ContentCubit, ContentState>(
//         builder: (context, state) {
//           if (state is ContentInitial) {
//             return Center(
//               child: ElevatedButton(
//                 onPressed: () => context.read().fetchAndStoreContent('en'),
//                 child: const Text('Download Content'),
//               ),
//             );
//           } else if (state is ContentLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ContentDownloaded) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Content downloaded successfully!'),
//                 ElevatedButton(
//                   onPressed: () => context.read().saveImagesToLocal('en'),
//                   child: const Text('Save Images Locally'),
//                 ),
//               ],
//             );
//           } else if (state is ContentSavedToStorage) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Images saved to local storage!'),
//                 Text('Saved paths:\n${state.savedPaths.join('\n')}'),
//               ],
//             );
//           } else if (state is ContentError) {
//             return Center(
//               child: Text('Error: ${state.message}'),
//             );
//           }
//           return const SizedBox();
//         },
//       );
//   }
// }
