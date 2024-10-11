import 'package:flutter/material.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'productcard.dart';
import '../models/producto_botica.dart';
import 'package:get/get.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductoBotica> productos;
  final Function(ProductoBotica) onProductTap;

  const ProductGridView({
    Key? key,
    required this.productos,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.63,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        ProductoBotica producto = productos[index];
        return GestureDetector(
          onTap: () => onProductTap(producto),
          child: ProductCard(
            imageUrl: producto.imagen,
            title: '${producto.nombre} | ${producto.marca}',
            description: producto.presentacion,
            price: producto.precio,
            onAddPressed: () {
              cartController.addToCart(producto);
              print('Producto añadido al carrito');
            },
            chipLabel: producto.botica,
            chipTextColor: Colors.black,
            chipBackgroundColor: Color(0xFFCCCCCC),
            chipFontSize: 9,
          ),
        );
      },
    );
  }
}
