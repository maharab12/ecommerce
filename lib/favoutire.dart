
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Buy.dart';
class Change with ChangeNotifier {
  bool item = false;
  String keytext = '';
  changekeytext(value){
    keytext=value;
    notifyListeners();
  }
  void clearkeytext(){
    keytext='';
    notifyListeners();
  }
  void changeItem() {
    item = !item;
    notifyListeners();
  }
}
class favitem with ChangeNotifier {
  List<int> favorite = [];
  List<Map<String, dynamic>> productTitles = [];

  void adtofav(
      int index, String title, String price, String image,String des) {
    favorite.add(index);
    productTitles.add({'index':index,'title':title,'price':price,'image':image,'des':des});


    notifyListeners();
  }

void removproduct(indexed){
    favorite.remove(indexed);
    productTitles.removeWhere((element) =>
    element["index"]==indexed);

    notifyListeners();
}



}

class selected_item extends StatelessWidget {
  var index;
  var Price;
  String Title;
  String Desc;
  var image;
  selected_item ({
    required this.index,
    required this.Title,
    required this.Desc,
    required this.Price,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<favitem>().favorite;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              color: Colors.white70,
              child: Column(
                children: [
                  Image.network(image),
                  ListTile(
                    title: Text(
                      '${Title.substring(0, Title.length > 50 ? 50 : Title.length)}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      Desc.substring(0, Desc.length > 150 ? 150 : Desc.length),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (fav.contains(index)) {
                              context.read<favitem>().removproduct(index);
                            } else {
                              context.read<favitem>().adtofav(index, Title, Price, image, Desc);
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: fav.contains(index) ? Colors.red : Colors.black26,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  Buy(context:context,image: image, title: Title, price: Price),
                            );

                          },
                          child: Text(
                            "Buy",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: 35),
              ),
            )
          ],
        ),
      ),
    );
  }
}

