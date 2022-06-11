//Estableceremos los colores de estilo de la aplicación
import 'package:flutter/material.dart';

/*
Clase que permite establecer los colores que se utilizarán en la aplicación
recién creada. De esta manera, será más fácil y rápido saber qué colores
utilizar para hacer que la aplicación sea más armoniosa y armoniosa a nivel gráfico.
En lugar de esta clase en el desarrollo de la aplicación se podría utilizar
el color semilla, es decir, la funcionalidad que basa todo el color de la aplicación
en relación con un solo color, este método actúa como el color básico y que a mano
se van creando diferentes tonos del mismo color elegido como principal.
*/

class AppStyle {
  // ignore: prefer_const_constructors
  static Color primaryColor = Color.fromARGB(255, 1, 60, 79);
  // ignore: prefer_const_constructors
  static Color textInputColor = Color.fromARGB(255, 0, 0, 0);
  // ignore: prefer_const_constructors
  static Color accentColor = Color.fromARGB(255, 255, 255, 255);
}
