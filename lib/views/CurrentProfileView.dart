
import "package:flutter/material.dart";

import "../constants.dart";
import "../controllers/link_controller.dart";
import "../controllers/user_controller.dart";
import "../models/link.dart";
import "../models/user.dart";

class CurrentProfile extends StatefulWidget {
  static String id = "/current";
  const CurrentProfile({Key? key}) : super(key: key);

  @override
  State<CurrentProfile> createState() => _CurrentProfileState();
}

class _CurrentProfileState extends State<CurrentProfile> {

  late User? user;
  late List<Link?>? links;

  getAllData(context)async{
    user = await getLocalUser();
    links = await getLinks(context);
    setState(() {

    });
  }

  @override
  void initState() {
    user = null;
    links = null;
    getAllData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(user == null || links == null){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kLightSecondaryColor,
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue, // Placeholder color
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.blue, // Placeholder color
                    child: Text(
                      user != null ? user!.user!.name.toString()[0] : "loading",
                      style: const TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    user != null ? user!.user!.name.toString() : "loading",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            links != null ? Expanded(
              child: ListView.builder(
                itemCount: links!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(links![index]!.title.toString()),
                    subtitle: Text(links![index]!.link.toString()),
                  );
                },
              ),
            ): Container(),
          ],
        ),
      );
    }
      }
}
