import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryForm extends StatefulWidget {
  const GalleryForm({Key? key, required this.space, required this.formKey}) : super(key: key);

  final Space space;
  final GlobalKey<FormState> formKey;

  @override
  State<GalleryForm> createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  List<XFile> files = [];
  List<Widget> gallery = [];
  String? error;
  @override
  Widget build(BuildContext context) {
    gallery = files
        .map((e) => FutureBuilder(
              future: e.readAsBytes(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                  ? loader
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Image.memory(snapshot.data as Uint8List),
                          IconButton(
                            onPressed: () => setState(() => files.remove(e)),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
            ))
        .toList();
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              child: const Text('Find Images'),
              onPressed: () async {
                List<XFile>? newFiles = await ImagePicker().pickMultiImage(maxHeight: 1080, maxWidth: 1920);
                if (newFiles != null) {
                  setState(() {
                    files.addAll(newFiles);
                  });
                }
              }),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: gallery,
            ),
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            child: const Text('Finish'),
            onPressed: () async {
              try {
                if (!widget.formKey.currentState!.validate()) {
                  setState(() => error = "Some data is missing or is wrongly formated");
                } else {
                  await Space.createSpace(context.read<Person?>()!, widget.space, images: files);
                  Navigator.of(context).pop();
                }
              } catch (e) {
                print(e.toString());
              }
            },
          ),
          if (error != null) Text(error!),
        ],
      ),
    );
  }
}
