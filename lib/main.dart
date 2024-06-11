import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/seller_account/login_to%20seller%20account.dart';

import 'package:untitled8/show_search%20tem.dart';
import 'appbar.dart';
import 'favoutire.dart';
import 'card_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAF2X_lpIYAzBdZxPx2VyoCMawElpAUFGs",
      appId: "1:626462932278:android:77d40f4c5abaaa5d308797",
      messagingSenderId: "1:626462932278",
      projectId: "ecomars-b7a9d",
    ),
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => favitem()),
      ChangeNotifierProvider(create: (_) => Change()),
    ],
    child: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  Future<List<QueryDocumentSnapshot>> Offer() async {
    var s = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await s.collection('discount').get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> get() async {
    var s = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await s.collection("products").get();
    return querySnapshot.docs;
  }



    @override
  Widget build(BuildContext context) {


    return SafeArea(

      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        child: Scaffold(

          drawer: Drawer(
            child: Container(color: Colors.red,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.holiday_village_rounded),
                  title: Text('Seller Account'),
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>Login_toseller()));
                  },
                )
              ],
            ),
            ),
          ),
          backgroundColor: Colors.white70,
          appBar: AppBar(
            title:GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchbar()));
              },
              child: Row(
                children: [
                  Container(
                    color: Colors.black12,
                      child: Text("Search product..."))
                ],
              )
            ),
          ),

          body: FutureBuilder<List<QueryDocumentSnapshot>>(
            future: get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
               }else {
                List<QueryDocumentSnapshot> documents = snapshot.data ?? [];

                if (documents.isEmpty) {
                  return Center(
                    child: Text('No data available'),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                          itemCount: 2,
                          itemBuilder: (context, index, realIndex) {
                            return FutureBuilder<List<QueryDocumentSnapshot>>(
                              future: Offer(),
                              builder: (_, offerSnapshot) {
                                if (offerSnapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (offerSnapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${offerSnapshot.error}'),
                                  );
                                } else {
                                  List<QueryDocumentSnapshot> offer = offerSnapshot.data ?? [];
                                  if (offer.isEmpty) {
                                    return Center(
                                      child: Text('No offers available'),
                                    );
                                  }
                                  String offerText = offer[index].get("offer") as String;
                                  return Container(
                                    child: Text(offerText),
                                  );
                                }
                              },
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 4,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.5,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
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
                                String title = documents[index].get("title");
                                String desc = documents[index].get("desc");
                                String image = documents[index].get("Urls").toString();
                                String price = documents[index].get("prices").toString();

                                return GestureDetector(

                                  onTap: () {
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              selected_item(
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
                              itemCount: documents.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            // else {
            //
            //    String keytext=context.read<Change>().keytext;
            //     return buildSearchResults(context, snapshot.data ?? [], keytext);
            //
            //   }
            },
          ),
          floatingActionButton: Stack(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favorite()),
                  );
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              Positioned(
                top: -8,
                right: -0.2,
                child: Consumer<favitem>(
                  builder: (context, favItems, _) => Text(
                    "${favItems.favorite.length}",
                    style: TextStyle(fontSize: 30, color: Colors.pink),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
