import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/main.dart';
import 'favoutire.dart';

class Card_Buy extends StatelessWidget {
  Card_Buy({super.key}){
_confettiController = ConfettiController(duration: Duration(seconds: 5));
}

  late ConfettiController _confettiController;


  @override
  Widget build(BuildContext context) {


    int totalPrice = context
        .read<favitem>()
        .productTitles
        .map((e) => int.parse(e['price']))
        .fold(0, (previousValue, element) => previousValue + element);

    int deliveryCharge = 75;

    List<TableRow> productRows = context
        .read<favitem>()
        .productTitles
        .map((e) => TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e['title']),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e['price']),
          ),
        ),
      ],
    ))
        .toList();

    productRows.add(
      TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Total'),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text((totalPrice + deliveryCharge).toString()),
            ),
          ),
        ],
      ),
    );

    productRows.insert(
      productRows.length - 1,
      TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delivery Charge'),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(deliveryCharge.toString()),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              children: productRows,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 110, left: 110),
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {
                    _confettiController.play(); // Play the confetti animation
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: 0,
                          emissionFrequency: 0.2,
                          numberOfParticles: 4,
                          maxBlastForce: 30,
                          minBlastForce: 10,
                          child: Container(
                            height: 300,
                            width: 500,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    "Congratulations! Your order is successful !",
                                    style: TextStyle(fontSize: 28, color: Colors.brown),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 7,
                                  child:ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the bottom sheet
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  )

                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ).then((value) {
                      // Called when the bottom sheet is closed
                      final favItem = context.read<favitem>();
                      List<Map<String, dynamic>> productTitlesCopy = List.from(favItem.productTitles);
                      for (var item in productTitlesCopy) {
                        favItem.removproduct(item['index']);
                      }
                    });
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 30, color: Colors.purple),
                  ),
                )




              ]),
            )
          ],
        ),
      ),
    );
  }
}

