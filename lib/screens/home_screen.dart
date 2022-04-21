import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants/color.dart';
import 'package:shop_app/constants/text_style.dart';
import 'package:shop_app/constants/url.dart';
import 'package:shop_app/database/db_provider.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/get_product_provider.dart';
import 'package:shop_app/screens/detail_screen.dart';
import 'package:shop_app/utils/routes.dart';
import 'package:shop_app/widgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductProvider().getProduct();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Shopping app" , style: appTitle,),
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
        child: FutureBuilder<Product>(
          future: getProductProvider().getProduct() ,
          builder: (context, snapshot){
            print(snapshot);
            if (snapshot.hasError) {
              return const Center(child: Text("Error Occured"),);
            }  else if (snapshot.hasData) {
              if (snapshot.data!.products == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Product List is empty"),
                    ],
                  ),
                );
              } else {
                return ListView(

                  children:
                    List.generate(snapshot.data!.products!.length, (index){
                      final data = snapshot.data!.products![index];
                      return GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(page: DetailScreen(id: data.id.toString()));
                        },
                        child: ProductContainer(
                            name: data.name.toString(),
                            description: data.description.toString(),
                            image: data.image.toString(),
                            date: data.timeStamp.toString(),
                            price: data.price.toString(),
                          type: 1,
                        ),
                      );
                    })
                  ,
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        )
      ),
    );
  }
}
