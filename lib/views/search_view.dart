import "package:flutter/material.dart";
import "package:tt9_betweener_challenge/controllers/searchController.dart";
import "package:tt9_betweener_challenge/views/profile_view.dart";
import "package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart";

import "../constants.dart";

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  static String id = "/search";

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchForNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>?> search;

  workSetState(){
    setState(() {
      search = goToSearchController();
    });
  }

  Future<List<dynamic>?> goToSearchController() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> body = {
        "name": searchForNameController.text,
      };
      final results = await searchController(body);
      print(results);
      return results;

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    search = goToSearchController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: searchForNameController,
                  decoration: const InputDecoration(
                    hintText: "search for name",
                    labelText: "Search",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Search for name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              SecondaryButtonWidget(
                  onTap: workSetState, text: 'SEARCH'),
              FutureBuilder(
                future: search,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(ProfileView.id, arguments: {
                                "name": snapshot.data![index]["name"] as String,
                                "id": snapshot.data![index]["id"] as int,
                                "links": snapshot.data![index]["links"] as List<dynamic>,
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kLightSecondaryColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(snapshot.data![index]["name"]),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("${snapshot.error}"),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Nothing Data"),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
