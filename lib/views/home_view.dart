import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/add_link_view.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  void addLink() {
    Navigator.of(context).pushNamed(AddLinkView.id).then((value) {
      if (value == true) {
        setState(() {
          links = getLinks(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Welcome ${snapshot.data?.user?.name}');
              }
              return const Text('loading');
            },
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: Image.asset(
              "assets/imgs/qr_code.png",
              fit: BoxFit.fill,
            ),
          ),
          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 80,
                  child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final link = snapshot.data?[index].title;
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: kLightSecondaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            '$link',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemCount: snapshot.data!.length),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Text('loading');
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: addLink,
              backgroundColor: kSecondaryColor,
              child: const Icon(Icons.add),
            ),
          ),
          // const Spacer(
          //   flex: 2,
          // ),
        ],
      ),
    );
  }
}
