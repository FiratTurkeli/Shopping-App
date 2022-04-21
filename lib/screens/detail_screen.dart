import 'package:flutter/material.dart';
import 'package:shop_app/models/product_detail_model.dart';
import 'package:shop_app/providers/get_product_detail_provider.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';
import '../database/db_provider.dart';
import '../models/product_model.dart';
import '../providers/get_product_provider.dart';
import '../widgets/product_container.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetailProvider().getProductDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("Details" , style: appTitle,),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed:(){
              DatabaseProvider().logOut(context);
            },
            icon: Icon(Icons.exit_to_app_sharp), color: Colors.white,)
        ],
      ),
      body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<ProductDetail>(
            future: getProductDetailProvider().getProductDetail(widget.id) ,
            builder: (context, snapshot){
              print(snapshot);
              if (snapshot.hasError) {
                return const Center(child: Text("Error Occured"),);
              }  else if (snapshot.hasData) {
                if (snapshot.data!.product == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Product List is empty"),
                      ],
                    ),
                  );
                } else {
                  final data = snapshot.data!;
                  return SingleChildScrollView(
                    child: ProductContainer(
                        name: data.product!.name.toString(),
                        description: data.product!.description.toString(),
                        image: data.product!. image.toString(),
                        date: data.product!.timeStamp.toString(),
                        price: data.product!.price.toString(),
                      type: 2,
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          )
      ),
    );;
  }
}
