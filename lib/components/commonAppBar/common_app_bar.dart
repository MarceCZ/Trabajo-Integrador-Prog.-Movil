import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/colors.dart';
import 'common_app_bar_controller.dart';
import '../../models/usuario.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CommonAppBarController control = Get.put(CommonAppBarController());

  CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(
            'assets/img/logo2.png',
            width: 40.0,
          ),
          SizedBox(width: 8.0),
          Text(
            'Mediplan+',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 30.0),
         /* Obx(() {
            return control.usuario.value.idUsuario != 0
                ? IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      print("Botón de perfil presionado");
                      Navigator.pushNamed(context, '/profile'); // Asegúrate de que este contexto es correcto
                    },
                  )
                : SizedBox.shrink();
          }),*/
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        Obx(() {
            return control.usuario.value.idUsuario != 0 ?
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        )
        : SizedBox.shrink();
        }),
      ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


/*
AppBar CommonAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Image.asset(
          'assets/img/logo2.png',
          width: 40.0,
        ),
        SizedBox(width: 8.0),
        Text('Mediplan+',
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w700)),
        SizedBox(width: 10.0),
        
            IconButton(
              icon: Icon(Icons.person), 
              onPressed: () {
                print("Botón de perfil presionado");
                Navigator.pushNamed(context, '/profile');
              },
            ),
        
      ],
    ),
  );
}*/

/*
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBarController control = Get.put(CommonAppBarController());
  Usuario? usuario;
  CommonAppBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/img/logo2.png',
            width: 40.0,
          ),
          SizedBox(width: 8.0),
          Text(
            'Mediplan+',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 170.0),
          Obx(() {
            return control.usuario.value.idUsuario !=
                    0 // Cambia esto según tu lógica
                ? IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      print("Botón de perfil presionado");
                      Navigator.pushNamed(context, '/profile'); 
                    },
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  // Altura de la AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}
*/
/*
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CommonAppBarController control = Get.put(CommonAppBarController());

  CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(
            'assets/img/logo2.png',
            width: 40.0,
          ),
          SizedBox(width: 8.0),
          Text(
            'Mediplan+',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 30.0),
          Obx(() {
            return control.usuario.value.idUsuario != 0
                ? IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      print("Botón de perfil presionado");
                      Navigator.pushNamed(context, '/profile'); // Asegúrate de que este contexto es correcto
                    },
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}*/