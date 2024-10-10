import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_detail_controller.dart';
import '../../components/common_app_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailController controller = Get.put(ProductDetailController());
  final int pId;

  ProductDetailPage({Key? key, required this.pId}) {
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Text('hola')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
    );
  }
}
