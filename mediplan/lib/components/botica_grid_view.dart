import 'package:flutter/material.dart';
import '../models/botica.dart';
import 'boticacard.dart';

class BoticaGridView extends StatelessWidget {
  final List<Botica> boticas;
  final Function(Botica) onBoticaTap;

  const BoticaGridView({
    Key? key,
    required this.boticas,
    required this.onBoticaTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: boticas.length,
      itemBuilder: (context, index) {
        Botica botica = boticas[index];
        return BoticaCard(
          imageUrl: botica.logo,
          title: botica.nombre,
          productCount: botica.cantidadProductos,
          onTap: () => onBoticaTap(botica),
        );
      },
    );
  }
}
