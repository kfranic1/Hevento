import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:image_picker/image_picker.dart';

class GalleryForm extends StatefulWidget {
  const GalleryForm({Key? key, required this.space, required this.formKey, required this.images, required this.newImages}) : super(key: key);

  final Space space;
  final GlobalKey<FormState> formKey;
  final List<CustomNetworkImage> images;
  final List<XFile> newImages;

  @override
  State<GalleryForm> createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  String? error;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          ElevatedButton(
              child: const Text('Dodaj nove slike'),
              onPressed: () async {
                List<XFile>? newFiles = await ImagePicker().pickMultiImage(maxHeight: 1080, maxWidth: 1920);
                if (newFiles != null) {
                  setState(() {
                    widget.newImages.addAll(newFiles);
                  });
                }
              }),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.newImages
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
                                      onPressed: () => setState(() {
                                        widget.newImages.remove(e);
                                      }),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ))
                  .toList(),
            ),
          ),
          if (widget.images.isNotEmpty) ...[
            const Text("Ukloni stare slike."),
            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.images
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              e,
                              IconButton(
                                onPressed: () => setState(() {
                                  widget.space.removeImage(e.imageName!);
                                  widget.images.remove(e);
                                }),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const Text(
              "Napomena: brisanje slika je automatsko",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
          const SizedBox(height: 20),
          if (error != null) Text(error!),
        ],
      ),
    );
  }
}
