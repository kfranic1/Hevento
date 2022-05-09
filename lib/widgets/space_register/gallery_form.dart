import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:image_picker/image_picker.dart';

class GalleryForm extends StatefulWidget {
  const GalleryForm({Key? key, required this.space, required this.formKey, required this.images}) : super(key: key);

  final Space space;
  final GlobalKey<FormState> formKey;
  final List<CustomNetworkImage> images;

  @override
  State<GalleryForm> createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  String? error;
  bool loading = false;
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
                if (newFiles == null) return;
                setState(() {
                  loading = true;
                });
                await widget.space.addImages(newFiles);
                widget.images.addAll(newFiles.map((e) => CustomNetworkImage(spaceId: widget.space.id, imageName: e.name)));
                setState(() {
                  loading = true;
                });
              }),
          if (widget.images.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.images
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: e,
                                  ),
                                  CircleAvatar(
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => setState(() {
                                        widget.space.removeImage(e.imageName);
                                        widget.images.remove(e);
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                child: Text(
                                  "Postavi kao glavnu sliku",
                                  style: TextStyle(color: e.imageName == widget.space.profileImage ? darkGreen : Colors.black),
                                ),
                                onPressed: () => setState(() {
                                  widget.space.profileImage = e.imageName;
                                  widget.space.updateSpace();
                                }),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 20),
          if (error != null) Text(error!),
        ],
      ),
    );
  }
}
