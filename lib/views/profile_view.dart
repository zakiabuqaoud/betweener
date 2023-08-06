import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';

import '../constants.dart';

class ProfileView extends StatelessWidget {
  static String id = '/profileView';
  final Color profileImageColor = Colors.blue;

  ProfileView({super.key});
  // followee_id
 followUser(followee_id)async{
   print(followee_id);
   final body = {
     "followee_id": followee_id as int,
   };

   final b = await followController(body);
   if(b == true){
     print("follow success");
   }

 }


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                    arguments['name'][0],
                    style: const TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  arguments['name'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async{
                    await followUser(arguments["id"] as int);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(kSecondaryColor), // Background color
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                    child: const Text('Follow'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
          arguments["links"] != null ? Expanded(
            child: ListView.builder(
              itemCount: arguments["links"].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(arguments["links"][index]["title"]),
                  subtitle: Text(arguments["links"][index]["link"]),
                );
              },
            ),
          ): Container(),
        ],
      ),
    );
  }
}

class Item {
  final String title;
  final String subtitle;

  Item(this.title, this.subtitle);
}
