
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'favoutire.dart';


Widget buildSearchResults(BuildContext context, List<QueryDocumentSnapshot> documents,String keytext) {
  List<QueryDocumentSnapshot> filteredDocuments = documents.where((doc) {
    String title = doc.get("title").toString().toLowerCase();
    return title.contains(keytext.toLowerCase());
  }).toList();


  if (filteredDocuments.isEmpty) {
    return Center(
      child: Text('No results found for "${keytext}"'),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // Adjust height as needed
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final fav = context.watch<favitem>().favorite;
                  String title = filteredDocuments[index].get("title");
                  String desc = filteredDocuments[index].get("desc");
                  String image = filteredDocuments[index].get("Urls").toString();
                  String price = filteredDocuments[index].get("prices").toString();

                  return GestureDetector(
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => selected_item(
                              Price: price,
                              image: image,
                              Title: title,
                              Desc: desc,
                              index: index,
                            ),
                          ),
                        );


                    },
                    child: Card(
                      elevation: 30,
                      child: Column(
                        children: [
                          SizedBox(height: 9),
                          Image.network(image),
                          Row(
                            children: [
                              Text(" ৳${price}"),
                              SizedBox(width: 90),
                              IconButton(
                                onPressed: () {
                                  if (fav.contains(index)) {
                                    context.read<favitem>().removproduct(index);
                                  } else {
                                    context.read<favitem>().adtofav(index, title, price, image, desc);
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: fav.contains(index) ? Colors.red : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: filteredDocuments.length,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
