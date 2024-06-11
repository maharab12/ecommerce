import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/show_search%20tem.dart';

import 'favoutire.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  Future<List<QueryDocumentSnapshot>> get() async {
    var s = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await s.collection("products").get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: TextFormField(

          style: TextStyle(backgroundColor: Colors.black12),
          onChanged: (value) {
            context.read<Change>().changekeytext(value);
          },

          decoration: InputDecoration(
            hintText: 'Search product..',
          ),
        ),
      ),

    body:  FutureBuilder<List<QueryDocumentSnapshot>>(
        future: get(),
    builder: (_, snapshot) {
    List<QueryDocumentSnapshot> documents = snapshot.data ?? [];
    return buildSearchResults(context,documents, context.read<Change>().keytext);
    }));}
}
