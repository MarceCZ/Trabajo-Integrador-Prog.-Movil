import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/customchip.dart';
import 'package:mediplan/pages/kitSettingPage/kit_setting_controller.dart';
import '../../components/commonAppBar/common_app_bar.dart';
import '../../components/common_drawer.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';
import '../../models/kit_producto.dart';

class KitSettingPage extends StatefulWidget {
  @override
  _KitSettingPageState createState() => _KitSettingPageState();
}

class _KitSettingPageState extends State<KitSettingPage> {
  final KitSettingController control = Get.put(KitSettingController());
  bool _existKit = true;

  Widget _build(BuildContext context) {
    return _existKit ? _buildBody(context) : _buildEmpty(context);
  }

  Widget _buildEmpty(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.backgroundColor2,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mi Kit mensual",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    constraints: BoxConstraints(
                      minHeight: 650.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('No tienes un kit mensual activo'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Volver',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.backgroundColor2,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mi Kit mensual",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    constraints: BoxConstraints(
                      minHeight: 650.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                title: Text('Productos',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor)),
                                children: [
                                  Obx(
                                    () => control.productos.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: control.productos.length,
                                            itemBuilder: (context, index) {
                                              return _buildProductItem(
                                                  control.productos[index]);
                                            },
                                          ),
                                  )
                                ],
                              ),
                              ExpansionTile(
                                title: Text('Detalles de entrega',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor)),
                                children: [
                                  Obx(
                                    () => control.departamento.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Departamento'),
                                            subtitle: Text(
                                                control.departamento.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.distrito.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Distrito'),
                                            subtitle:
                                                Text(control.distrito.value)),
                                  ),
                                  Obx(
                                    () => control.direccion.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Dirección'),
                                            subtitle:
                                                Text(control.direccion.value)),
                                  ),
                                  Obx(
                                    () => control.otro.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text(
                                                'Dpto/Nro/Piso/Referencia'),
                                            subtitle: Text(control.otro.value),
                                          ),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                title: Text('Mi suscripción',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor)),
                                children: [
                                  Obx(
                                    () => control.tipo.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Tipo de suscripción'),
                                            subtitle: Text(control.tipo.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.fechaInicio.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Fecha de inicio'),
                                            subtitle:
                                                Text(control.fechaInicio.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.fechaFin.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Fecha de fin'),
                                            subtitle:
                                                Text(control.fechaFin.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.total.value == 0.0
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Total'),
                                            subtitle: Text('S/ ' +
                                                control.total.value.toString()),
                                          ),
                                  ),
                                  Obx(
                                    () => control.pago.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Método de pago'),
                                            subtitle: Text(control.pago.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.fechaEntrega.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Fecha de entrega'),
                                            subtitle: Text(
                                                control.fechaEntrega.value),
                                          ),
                                  ),
                                  Obx(
                                    () => control.estado.value.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : ListTile(
                                            title: Text('Estado'),
                                            subtitle:
                                                Text(control.estado.value),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Button(
                                      title: 'Cancelar',
                                      onPressed: () {
                                        _showCancelDialog(context);
                                      },
                                      width: 200.0,
                                      textColor: AppColors.textColor,
                                      backgroundColor:
                                          AppColors.backgroundColor4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Volver',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(KitProducto producto) {
    return ListTile(
      leading: Image.network(
        producto.imagen,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(producto.nombre + ' | ' + producto.marca),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomChip(
              label: producto.botica,
              textColor: AppColors.secondaryColor,
              backgroundColor: AppColors.backgroundColor,
              onTap: (() => ()),
              fontSize: 10.0),
          Text('S/ ' + producto.subTotal.toString()),
          Row(
            children: [
              Text('Cantidad: ' + producto.cantidadProducto.toString()),
              SizedBox(width: 10.0),
              producto.receta
                  ? Icon(
                      Icons.medical_services,
                      color: Colors.red,
                    )
                  : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // El fondo se opacará y no se puede cerrar tocando fuera del diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "¿Estás seguro/a que deseas cancelar tu suscripción? ",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontSize: 30.0,
                )),
          ),
          actions: <Widget>[
            Button(
              title: 'No',
              onPressed: () {
                Navigator.of(context).pop();
              },
              width: 100.0,
              backgroundColor: AppColors.backgroundColor3,
            ),
            SizedBox(width: 50.0),
            Button(
              title: 'Sí',
              onPressed: () {
                control.cancelarSuscripcion();
                control.idKit = 0;
                control.idSuscripcion = 0;                
                setState(() {
                  _existKit = false; // Actualiza el estado aquí
                });
                Navigator.of(context).pop();
              },
              width: 100.0,
              textColor: AppColors.primaryColor,
              backgroundColor: AppColors.backgroundColor,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    control.idKit = 0;
    control.getKit();
    Future.delayed(Duration(seconds: 1), () {
      if (control.idKit == 0) {
        setState(() {
          _existKit = false;
        });
      }
    });
    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommonDrawer(),
      body: _build(context),
    );
  }
}
