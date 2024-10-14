import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_drawer.dart';
import './profile_controller.dart';
import '../../components/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';
import '../../components/customDateField.dart';
import '../../components/customTextLabel.dart';

class ProfilePage extends StatefulWidget {
  final ProfileController control = Get.put(ProfileController());
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  Widget _buildBodyRead(BuildContext context) {
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
                        "Mi perfil",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isEditing =
                                  !_isEditing; // Cambia entre edición y vista
                            });
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  // Formulario en tarjeta
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => widget.control.name.isNotEmpty
                                        ? CustomTextLabel(
                                            label: 'Nombre',
                                            text: widget.control.name.value)
                                        : CustomTextLabel(
                                            label: 'Nombre', text: ''),
                                  ),
                                  SizedBox(height: 10.0),
                                  Obx(
                                    () => widget.control.lastname.isNotEmpty
                                        ? CustomTextLabel(
                                            label: 'Apellido',
                                            text: widget.control.lastname.value)
                                        : CustomTextLabel(
                                            label: 'Apellido', text: ''),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons.person,
                                size: 40.0,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),

                        Obx(
                          () => widget.control.fecha.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Fecha de nacimiento',
                                  text: widget.control.fecha.value)
                              : CustomTextLabel(
                                  label: 'Fecha de nacimiento', text: ''),
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => widget.control.email.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Correo',
                                  text: widget.control.email.value)
                              : CustomTextLabel(label: 'Correo', text: ''),
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => widget.control.phone.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Celular',
                                  text: widget.control.phone.value)
                              : CustomTextLabel(label: 'Celular', text: ''),
                        ),
                        Divider(height: 40.0),
                        // Sección de salud
                        Text(
                          "Salud",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                                child: Obx(
                              () => widget.control.altura.isNotEmpty
                                  ? CustomTextLabel(
                                      label: 'Altura',
                                      text: widget.control.altura.value)
                                  : CustomTextLabel(label: 'Altura', text: ''),
                            )),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 25.0, left: 5.0, right: 65.0),
                              child: Text('m'),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                                child: Obx(
                              () => widget.control.peso.isNotEmpty
                                  ? CustomTextLabel(
                                      label: 'Peso',
                                      text: widget.control.peso.value)
                                  : CustomTextLabel(label: 'Peso', text: ''),
                            )),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 25.0, left: 5.0, right: 65.0),
                              child: Text('kg'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => widget.control.condicion.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Condiciones médicas',
                                  text: widget.control.condicion.value)
                              : CustomTextLabel(
                                  label: 'Condiciones médicas', text: ''),
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => widget.control.alergia.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Alergias',
                                  text: widget.control.alergia.value)
                              : CustomTextLabel(label: 'Alergias', text: ''),
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => widget.control.otros.isNotEmpty
                              ? CustomTextLabel(
                                  label: 'Otros',
                                  text: widget.control.otros.value)
                              : CustomTextLabel(label: 'Otros', text: ''),
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
                      SizedBox(width: 20.0),
                      Button(
                        title: 'Cerrar sesión',
                        onPressed: () {
                          widget.control.cerrarSesion();
                          Navigator.pushNamed(context, '/presentation');
                        },
                        fontSize: 16.0,
                        width: 180.0,
                        textColor: AppColors.textColor,
                        backgroundColor: AppColors.backgroundColor4,
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

  Widget _buildBodyEdit(BuildContext context) {
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
                  // Título
                  Text(
                    "Editar mi perfil",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),

                  // Formulario en tarjeta
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customtextfield(
                                    label: 'Nombre',
                                    controller: widget.control.txtname,
                                    hintText: 'Ingrese su(s) nombre(s)',
                                  ),
                                  Obx(() => widget.control.nameError.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            widget.control.nameError.value,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : SizedBox()),
                                  SizedBox(height: 10.0),
                                  Customtextfield(
                                    label: 'Apellido',
                                    controller: widget.control.txtlastname,
                                    hintText: 'Ingrese su(s) apellido(s)',
                                  ),
                                  Obx(() => widget
                                          .control.lastNameError.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            widget.control.lastNameError.value,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : SizedBox()),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons.person,
                                size: 40.0,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),

                        CustomDateField(
                          label: 'Fecha de nacimiento',
                          hintText: 'dd/mm/aaaa',
                          controller: widget.control.date,
                          onCalendarTap: () =>
                              widget.control.selectDate(context),
                        ),
                        Obx(() => widget.control.dateError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.control.dateError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 10.0),
                        Customtextfield(
                          label: 'Correo',
                          controller: widget.control.txtemail,
                          hintText: 'Ingrese su correo',
                        ),
                        Obx(() => widget.control.emailError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.control.emailError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 10.0),
                        Customtextfield(
                          label: 'Celular',
                          controller: widget.control.phonenumber,
                          hintText: 'Ingrese su número',
                        ),
                        Obx(() => widget.control.phoneError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.control.phoneError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        Divider(height: 40.0),
                        // Sección de salud
                        Text(
                          "Salud",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customtextfield(
                                    label: 'Altura',
                                    controller: widget.control.height,
                                  ),
                                  Obx(() => widget
                                          .control.heightError.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            widget.control.heightError.value,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : SizedBox()),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 25.0, left: 25.0),
                              child: Text('m'),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customtextfield(
                                    label: 'Peso',
                                    controller: widget.control.weight,
                                  ),
                                  Obx(() => widget
                                          .control.weightError.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            widget.control.weightError.value,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : SizedBox()),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 25.0, left: 25.0),
                              child: Text('kg'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Customtextfield(
                          label: 'Condiciones médicas',
                          controller: widget.control.condition,
                        ),
                        Obx(() => widget.control.conditionError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.control.conditionError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 10.0),
                        Customtextfield(
                          label: 'Alergias',
                          controller: widget.control.alergy,
                        ),
                        Obx(() => widget.control.alergyError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.control.alergyError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 10.0),
                        Customtextfield(
                          label: 'Otros',
                          controller: widget.control.others,
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Button(
                            title: 'Guardar',
                            onPressed: () {},
                            width: 200.0,
                            backgroundColor: AppColors.backgroundColor3,
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
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        child: Text(
                          'Cancelar',
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
    Future.delayed(Duration(seconds: 2), () {
      widget.control.buscarUsuario();
    });
    return _isEditing ? _buildBodyEdit(context) : _buildBodyRead(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommonDrawer(),
      body: _buildBody(context),
    );
  }
}
