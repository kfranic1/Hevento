import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_router_delegate.dart';

class PartnerPage extends StatelessWidget {
  PartnerPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "email"),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("ok");
                  try {
                    Provider.of<FirebaseFirestore>(context, listen: false)
                        .collection("mails")
                        .add({"mail": _emailController.text}).whenComplete(() => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToTest());
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Pošalji"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
