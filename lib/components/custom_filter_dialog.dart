import 'package:flutter/material.dart';
import '../configs/colors.dart';

class CustomFilterDialog extends StatefulWidget {
  final RangeValues rangoPrecioInicial;
  final double precioMin;
  final double precioMax;
  final List<String> marcas;
  final List<String> marcasSeleccionadas;
  final ValueChanged<RangeValues> onPrecioChanged;
  final ValueChanged<String> onMarcaChanged;

  const CustomFilterDialog({
    Key? key,
    required this.rangoPrecioInicial,
    required this.precioMin,
    required this.precioMax,
    required this.marcas,
    required this.marcasSeleccionadas,
    required this.onPrecioChanged,
    required this.onMarcaChanged,
  }) : super(key: key);

  @override
  _CustomFilterDialogState createState() => _CustomFilterDialogState();
}

class _CustomFilterDialogState extends State<CustomFilterDialog> {
  late RangeValues rangoPrecio;
  late List<String> marcasSeleccionadas;

  @override
  void initState() {
    super.initState();
    rangoPrecio = widget.rangoPrecioInicial;
    marcasSeleccionadas = List<String>.from(widget.marcasSeleccionadas);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filtrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Divider(),
            Text(
              'Precio',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SliderTheme(
              data: SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: Colors.grey,
                thumbColor: AppColors.primaryColor,
              ),
              child: RangeSlider(
                values: rangoPrecio,
                min: widget.precioMin,
                max: widget.precioMax,
                divisions: (widget.precioMax - widget.precioMin).toInt(),
                labels: RangeLabels(
                  'S/${rangoPrecio.start.round()}',
                  'S/${rangoPrecio.end.round()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    rangoPrecio = values;
                  });
                  widget.onPrecioChanged(values);
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Marca',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 10,
              children: widget.marcas.map((marca) {
                bool isSelected = marcasSeleccionadas.contains(marca);
                return FilterChip(
                  label: Text(marca),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        marcasSeleccionadas.add(marca);
                      } else {
                        marcasSeleccionadas.remove(marca);
                      }
                    });
                    widget.onMarcaChanged(marca);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
