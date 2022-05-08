import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryForm extends StatefulWidget {
  const GalleryForm({Key? key, required this.space, required this.formKey, required this.images}) : super(key: key);

  final Space space;
  final GlobalKey<FormState> formKey;
  final List<CustomNetworkImage> images;

  @override
  State<GalleryForm> createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  List<XFile> newImages = [];
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
                    newImages.addAll(newFiles);
                  });
                }
              }),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: newImages
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
                                        newImages.remove(e);
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
          if (widget.images.isNotEmpty) const Text("Ukloni stare slike."),
          if (widget.images.isNotEmpty)
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
          if (widget.images.isNotEmpty)
            const Text(
              "Napomena: brisanje slika je automatsko",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text(widget.space.id == "" ? "Stvori prostor" : "Uredi prostor"),
            onPressed: () async {
              try {
                if (!widget.formKey.currentState!.validate()) {
                  setState(() => error = "Nedostaju neki podatci ili su krivo formatirani.");
                } else {
                  if (widget.space.id == "") {
                    await Space.createSpace(context.read<Person?>()!, widget.space,
                        images: newImages, profileImage: newImages.isEmpty ? null : newImages.first.name);
                    List<Space> spaces = context.read<List<Space>>();
                    if (!spaces.any((element) => element.id == widget.space.id)) spaces.add(widget.space);
                    List<SpaceListItem> spaceItems = context.read<List<SpaceListItem>>();
                    if (!spaceItems.any((element) => element.space.id == widget.space.id)) spaceItems.add(SpaceListItem(space: widget.space));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Prostor uspješno stvoren.")));
                  } else {
                    await widget.space.updateSpace(images: newImages);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Promjene uspješno spremljene.")));
                  }
                  Navigator.of(context).pop(true);
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
