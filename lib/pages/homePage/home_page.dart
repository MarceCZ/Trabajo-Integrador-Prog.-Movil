import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../../components/common_app_bar.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/productcard.dart';
import '../../configs/colors.dart';

class HomePage extends StatelessWidget {
  HomeController control = Get.put(HomeController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Container(
            color: AppColors.backgroundColor5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                              title: 'Productos',
                              onPressed: () {
                                //logica
                              },
                              width: 180.0,
                              height: 40.0),
                          const SizedBox(width: 16.0),
                          Button(
                              title: 'Boticas',
                              onPressed: () {
                                //logica
                              },
                              width: 180.0,
                              height: 40.0),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.0,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar producto',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Button(
                            title: 'Filtrar',
                            onPressed: () {
                              //logica
                            },
                            height: 40.0),
                        ProductCard(
                          imageUrl: 'https://dcuk1cxrnzjkh.cloudfront.net/imagesproducto/011592L.jpg',
                          title: 'Gel Hidratante Facil Hydro Boost | Neutrogena',
                          description: 'POTE 50G',
                          price: 55.40,
                          onAddPressed: (){
                            print('Producto añadido al carrito');
                          }
                          
                        ),
                      ],
                    ),
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(),
        body: _buildBody(context),
      ),
    );
  }
}
