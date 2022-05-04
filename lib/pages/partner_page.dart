import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatelessWidget {
  final String? params;
  final Space space = Space("");

  PartnerPage({Key? key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () async => await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Form(
                      child: SizedBox(
                        width: 500,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Create space"),
                              TextFormField(
                                decoration: const InputDecoration(hintText: "name"),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => space.name = value,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(hintText: "description"),
                                maxLines: 10,
                                onChanged: (value) => space.description = value,
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await Space.createSpace(context.read<Person?>()!, space);
                                  },
                                  child: const Text("Stvori oglas"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
          child: const Text("Stvori oglas")),
    );
  }
}
