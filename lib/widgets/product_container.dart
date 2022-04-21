import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';

class ProductContainer extends StatefulWidget {
  String name;
  String description;
  String image;
  String date;
  String price;
  int type;


  ProductContainer({Key? key, required this.name, required this.description, required this.image,  required this.date, required this.price, required this.type}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15)
          ),
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.name, style: bookName , textAlign:TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images" + widget.image),
              ),

              if (widget.type == 2)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.description, style: description, textAlign: TextAlign.center,),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price : " + widget.price, style: price,),
                    Text(DateFormat("dd/MM/yyyy hh:mm").format(DateTime.parse(widget.date),),style: date,),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
