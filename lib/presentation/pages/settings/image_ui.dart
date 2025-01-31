import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/image_bloc/image_bloc.dart';



class ImageUi extends StatelessWidget {
  const ImageUi({super.key});

  @override
  Widget build(BuildContext context) {
    final imageBloc = BlocProvider.of<ImageBloc>(context);
    imageBloc.add(LoadImagesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Load you favorite pictures'),
        centerTitle: true,
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImageLoadedState) {
            return Column(
              children: [
                Expanded(
                  child: state.images.isEmpty
                      ?const  Center(child: Text('No images found'))
                      : GridView.builder(
                          gridDelegate:
                             const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: state.images.length,
                          itemBuilder: (context, index) {
                            return
                                                    Padding(
                                                      padding: const EdgeInsets.all(1.0),
                                                      child: Container(
                                                                                  //padding: EdgeInsets.zero,
                                                            height: MediaQuery.of(context).size.width - 220,
                                                            width: MediaQuery.of(context).size.width - 220,
                                                            decoration: BoxDecoration(       
                                                                image: DecorationImage(
                                                                  image: FileImage(File(state.images[index].path)),
                                                                  fit: BoxFit.cover
                                                                ),
                                                            ),
                                                                                  //padding: EdgeInsets.zero,
                                                            child: Align(
                                                              alignment: Alignment.bottomCenter,
                                                              child: Container(
                                                                padding: EdgeInsets.zero,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius:BorderRadius.circular(100)
                                                                ),
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                   imageBloc.add(DeleteImageEvent(state.images[index]));
                                                                  },
                                                                  child:const Icon(
                                                                    Icons.delete,
                                                                    color:  Color.fromARGB(255, 234, 174, 9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                    );  
                          },
                        ),
                ),
                ElevatedButton(
                  onPressed: () => imageBloc.add(PickImageEvent()),
                  child: const Text('Pick Image from Gallery'),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
