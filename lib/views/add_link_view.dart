import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';

import 'widgets/secondary_button_widget.dart';

class AddLinkView extends StatefulWidget {
  static String id = "/add-link";

  const AddLinkView({Key? key}) : super(key: key);

  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  storeLink() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> body = {
        "title": titleController.text,
        "link": linkController.text,
      };

      addLink(body);

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Link"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Add title here",
                    labelText: "Title",

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the email';
                    }
                    return null;
                  },
                  controller: titleController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Add link here",
                    labelText: "Link",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the email';
                    }
                    return null;
                  },
                  controller: linkController,
                ),
                const SizedBox(
                  height: 28,
                ),
                SecondaryButtonWidget(onTap: storeLink, text: 'ADD LINK'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



