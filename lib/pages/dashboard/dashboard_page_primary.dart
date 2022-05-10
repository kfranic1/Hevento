import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/review_list.dart';
import 'package:hevento/widgets/space_register/space_form.dart';
import 'package:provider/provider.dart';

class DashboardPagePrimary extends StatefulWidget {
  const DashboardPagePrimary({Key? key}) : super(key: key);

  @override
  State<DashboardPagePrimary> createState() => _DashboardPagePrimaryState();
}

class _DashboardPagePrimaryState extends State<DashboardPagePrimary> {
  @override
  Widget build(BuildContext context) {
    Person appUser = context.read<Person?>()!;
    List<Space> mySpaces = context.read<List<Space>>().where((element) => element.owner.id == appUser.id).toList();
    mySpaces.sort((a, b) => a.name.compareTo(b.name));
    //? Ako zelimo da se sortira po tome jesu skriveni il ne => mySpaces.sort((a, b) => a.hidden ? 1 : 0);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: mySpaces.length,
                itemBuilder: (BuildContext context, int index) {
                  Space space = mySpaces[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      collapsedBackgroundColor: lightGreen,
                      title: Text(space.name),
                      subtitle: Text(space.address),
                      trailing: SizedBox(
                        height: 80,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                space.hidden = !space.hidden;
                                await space.updateSpace();
                                setState(() {});
                              },
                              icon: Icon(space.hidden ? Icons.visibility_off : Icons.visibility),
                              tooltip: "Sakrij oglas",
                            ),
                            TextButton(
                              child: const Text("Uredi"),
                              onPressed: () async => await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(content: SpaceForm(space: space)),
                              ).then((value) => setState(() {})),
                            ),
                          ],
                        ),
                      ),
                      maintainState: true,
                      expandedAlignment: Alignment.centerLeft,
                      childrenPadding: const EdgeInsets.only(left: 15),
                      children: [ReviewList(space: space)],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  height: 10,
                  thickness: 2,
                  color: darkGreen,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(content: SpaceForm()),
                    ).then((value) {
                      if (value != null && value as bool) setState(() {});
                    });
                  },
                  child: const Text("Stvori novi oglas"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
