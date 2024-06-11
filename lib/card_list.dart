import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'buy_form_card.dart';
import 'favoutire.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.watch<favitem>().productTitles;
    final fav=context.read<favitem>().favorite;

    return Scaffold(
      floatingActionButton: ElevatedButton(onPressed: (){
        fav.isNotEmpty?
         Navigator.push(context, MaterialPageRoute(builder: (context)=>
             Card_Buy()))
            :Fluttertoast.showToast(
            msg: "Pleasae add item",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0
        );
      },
        child: Text("Buy",style: TextStyle(fontSize: 30),),),
      appBar: AppBar(title: Text("favorite items"),backgroundColor: Colors.black12,),
      body: ListView(
        children: details.map((item) {
          final int index=item['index'];
          final String title = item['title'] ?? '';
          final String price = item['price'] ?? '';
          final String image = item['image'] ?? '';
          final String desc =item['des']??'';

          return Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(26),color: Colors.black12,),
              child: GestureDetector(
                onTap: (){
                  context.read<favitem>().productTitles;

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>selected_item (index:index, Title: title, Desc: desc, Price: price, image: image,)));
                },
                child: ListTile(
                  title: Text(title),


                  subtitle: RichText(
                    text: TextSpan(
                      text: '৳${price} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '3314', // Additional text
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic, // Additional text font style
                            decoration:(TextDecoration.lineThrough)
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: Image.network(image),
                  trailing: IconButton(onPressed: () {
                    Navigator.pop(context);
                  },
                    icon:IconButton(onPressed: (){
                      context.read<favitem>().removproduct(index);

                    },
                      icon: Text("remove",
                        style: TextStyle(color: Colors.red,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline)
                        ,),),// Assuming image is a URL
                  // Your widget configuration here
                ),
              ),
            ),
          ));
        }).toList(),
      ),
    );
  }
}
