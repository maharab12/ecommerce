import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/favoutire.dart';

Widget Buy({
  required BuildContext context, required String image, required String title, required String price}) {
  int deliveryCharge = 75;

  int total = int.parse(price) + deliveryCharge;
  var item=context.watch<Change>().item;


  return Container(
    height: 300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child:item? Show(context): Column(
        children: [
          Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Text("  $title", style: TextStyle(fontSize: 24)),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(price, style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text("Delivery Charge", style: TextStyle(fontSize: 24)),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(deliveryCharge.toString(), style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text("Total", style: TextStyle(fontSize: 24)),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(total.toString(), style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () {
                context.read<Change>().changeItem();


              },
              child: Text("Confirm", style: TextStyle(fontSize: 26)),
            ),
          ),
        ],
      ),
    ),
  );
}

class Show extends StatefulWidget {

  Show(BuildContext context);

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {

  @override
  Widget build(BuildContext context) {
    final ConfettiController _confettiController = ConfettiController(duration: Duration(milliseconds: 800));
    _confettiController.play();

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
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Congratulations! Your order is successful !",
                style: TextStyle(fontSize: 28, color: Colors.brown),
              ),

            ],
          ),Positioned(bottom: 15,right: 10,child: ElevatedButton(
              onPressed: (){

                Future.delayed(Duration(milliseconds: 180), () {
                  context.read<Change>().changeItem();

                });
                Navigator.pop(context);


              },
              child: Text("Ok",style: TextStyle(fontSize: 29),)),)]
        ),
      ),
    );
  }
}



