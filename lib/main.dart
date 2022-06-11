/*
Importación de todas las bibliotecas necesarias
para desarrollar el proyecto Visual QR.
*/
import 'dart:async';
// ignore: unused_import
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:visual_qr/ui/style/style.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

/*
función principal que permite previsualizar la aplicación
en los diferentes simuladores de teléfonos móviles.
*/
void main() {
  runApp(const MyApp());
}

/*
Clase principal que define las características gráficas y
que sirve para el lanzamiento y visualización de la aplicación
en simuladores de teléfonos móviles. 
*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      // ignore: prefer_const_constructors
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
Creación de segunda clase y definición del estado de la misma. 
*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/*
Segunda clase que forma la primera pantalla real de la aplicación.
Contiene la página de inicio del appp, es decir, la de creación del QR Code.
*/

class _HomeScreenState extends State<HomeScreen> {
  String data = "";
  // ignore: prefer_final_fields, unused_field
  String _scanBarcode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Definición de parámetros gráficos y estructurales
      appBar: AppBar(
        title: const Text('Create your QR'),
        backgroundColor: AppStyle.accentColor,
        foregroundColor: AppStyle.textInputColor,
      ),
      backgroundColor: AppStyle.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            //visualización gráfica de código QR
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              version: QrVersions.auto,
              size: 250.0,
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 25,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            //visualización gráfica del campo de texto
            width: 250.0,
            child: TextField(
              //generaremos un nuevo código qr cuando el valor de entrada cambie
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              textAlign: TextAlign.center,
              // ignore: prefer_const_constructors
              style: TextStyle(
                // ignore: prefer_const_constructors
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              decoration: InputDecoration(
                hintText: "Type characters...",
                filled: true,
                fillColor: AppStyle.accentColor,
                border: InputBorder.none,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 25.0,
          ),
          //visualización gráfica del botón
          RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _MySignature()),
              );
            },
            fillColor: AppStyle.accentColor,
            // ignore: prefer_const_constructors
            shape: StadiumBorder(),
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            // ignore: prefer_const_constructors
            child: Text(
              "Sign your QR",
            ),
          )
        ],
      ),
    );
  }
}

/*
Creación tercera clase y definición del estado de la misma. 
*/

class _MySignature extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MySignature({Key? key}) : super(key: key);

  @override
  _MySignatureState createState() => _MySignatureState();
}

/*
Creación de la tercera clase, fundamental, que define la pantalla
de firma y todos los parámetros para poder dibujar su propia firma.
*/

class _MySignatureState extends State<_MySignature> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

/*
variable inicializada que servirá para borrar el diseño
para establecer el restablecimiento de lo que se ha hecho.
*/
  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

/*
variable inicializada que servirá para la visualización
en forma única de la forma o dibujo realizado.
*/
  // ignore: unused_element
  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            //Definición de parámetros gráficos y estructurales
            appBar: AppBar(
              title: const Text('Go Back'),
              backgroundColor: AppStyle.accentColor,
              foregroundColor: AppStyle.textInputColor,
            ),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

/*
Override que establece la segunda pantalla de firma de obra QR
a través de la definición de gráficos y navegación interna de la aplicación.
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Definición de parámetros gráficos y estructurales
        backgroundColor: AppStyle.primaryColor,
        appBar: AppBar(
          title: const Text('Sign your QR'),
          backgroundColor: AppStyle.accentColor,
          foregroundColor: AppStyle.textInputColor,
        ),
        body: Column(
            children: [
              Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          // ignore: prefer_const_constructors
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          // ignore: prefer_const_constructors
                          strokeColor: Color.fromARGB(255, 0, 0, 0),
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0),
                      decoration: BoxDecoration(
                          border:
                              // ignore: prefer_const_constructors
                              Border.all(
                                  // ignore: prefer_const_constructors
                                  color: Color.fromARGB(255, 0, 0, 0))))),
              // ignore: prefer_const_constructors
              SizedBox(height: 8),
              Row(children: <Widget>[
                //primer botón de visualización pantalla única de la firma
                TextButton(
                  // ignore: prefer_const_constructors
                  child: Text('Image'),
                  onPressed: _handleSaveButtonPressed,
                  style: TextButton.styleFrom(
                    // ignore: prefer_const_constructors
                    primary: Color.fromARGB(255, 255, 255, 255),
                    // ignore: prefer_const_constructors
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    fixedSize: const Size(100, 35),
                  ),
                ),
                //segundo botón de borrado de diseño hecho, reset firma
                TextButton(
                  // ignore: prefer_const_constructors
                  child: Text('Clear'),
                  onPressed: _handleClearButtonPressed,
                  style: TextButton.styleFrom(
                    // ignore: prefer_const_constructors
                    primary: Color.fromARGB(255, 255, 255, 255),
                    // ignore: prefer_const_constructors
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    fixedSize: const Size(100, 35),
                  ),
                ),
                /*
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // ignore: prefer_const_constructors
                  child: Text('Go back!'),
                  style: TextButton.styleFrom(
                    // ignore: prefer_const_constructors
                    primary: Color.fromARGB(255, 255, 255, 255),
                    // ignore: prefer_const_constructors
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),*/
                //Tercer botón de apaertura a la tercera pantalla de la aplicación
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // ignore: prefer_const_constructors
                      MaterialPageRoute(builder: (context) => MyQrApp()),
                    );
                  },
                  fillColor: AppStyle.accentColor,
                  // ignore: prefer_const_constructors
                  shape: StadiumBorder(),
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 10.0,
                  ),
                  // ignore: prefer_const_constructors
                  child: Text(
                    "QR scan",
                  ),
                )
                /*
                ElevatedButton(
                  onPressed: () => scanQR(),
                  // ignore: prefer_const_constructors
                  child: Text('QR scan'),
                  style: TextButton.styleFrom(
                    // ignore: prefer_const_constructors
                    primary: Color.fromARGB(255, 255, 255, 255),
                    // ignore: prefer_const_constructors
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),*/
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center));
  }

/*
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // ignore: avoid_print
      print(barcodeScanRes);
      // ignore: nullable_type_in_catch_clause
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
*/
}

/*
definición de tercera clase y creación de su estado.
*/

class MyQrApp extends StatefulWidget {
  const MyQrApp({Key? key}) : super(key: key);

  @override
  _MyQrAppState createState() => _MyQrAppState();
}

/*
Creación de clase que contiene todos los parámetros gráficos
y de navegación interna de la aplicación y que ofrece la
tercera y última pantalla de la aplicación.
*/

class _MyQrAppState extends State<MyQrApp> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

/*
Variable futura que establece la perspectiva de la cámara trasera
y ofrece la posibilidad de ver los datos de un código de barras.
*/

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        // ignore: avoid_print
        .listen((barcode) => print(barcode));
  }

/*
Variable futura que establece la perspectiva de la cámara trasera
y ofrece la posibilidad de ver los datos de un escáner QR.
*/

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // ignore: avoid_print
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

/*
If que estabelece si el widget fue eliminado del árbol mientras el mensaje
de la plataforma asíncrona estaba en vuelo, queremos descartar la respuesta
en lugar de llamar a setState para actualizar nuestra apariencia inexistente.
*/
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  //Los mensajes de plataforma son asíncronos, por lo que inicializamos en un método asíncrono.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    //Los mensajes de la plataforma pueden fallar, por lo que utilizamos un try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // ignore: avoid_print
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

/*
If que estabelece si el widget fue eliminado del árbol mientras el mensaje
de la plataforma asíncrona estaba en vuelo, queremos descartar la respuesta en
lugar de llamar a setState para actualizar nuestra apariencia inexistente.
*/
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

/*
Ovveride inicializa todos los parámetros de la tercera pantalla
de la aplicación, como los botones, el graficha, los colores, etc.
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Definición de parámetros gráficos y estructurales
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: AppStyle.primaryColor,
            appBar: AppBar(
              title: const Text('Scans the QR'),
              backgroundColor: AppStyle.accentColor,
              foregroundColor: AppStyle.textInputColor,
            ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Primer botón que inicia el evento escanear código de barras
                        ElevatedButton(
                          onPressed: () => scanBarcodeNormal(),
                          // ignore: prefer_const_constructors
                          child: Text('Barcode Scan'),
                          style: TextButton.styleFrom(
                            // ignore: prefer_const_constructors
                            primary: Color.fromARGB(255, 255, 255, 255),
                            // ignore: prefer_const_constructors
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            fixedSize: const Size(180, 40),
                          ),
                        ),
                        //segundo botón que inicia el evento escanear QR Code
                        ElevatedButton(
                          onPressed: () => scanQR(),
                          // ignore: prefer_const_constructors
                          child: Text('QR Scan'),
                          style: TextButton.styleFrom(
                            // ignore: prefer_const_constructors
                            primary: Color.fromARGB(255, 255, 255, 255),
                            // ignore: prefer_const_constructors
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            fixedSize: const Size(180, 40),
                          ),
                        ),
                        /*
                        ElevatedButton(
                            onPressed: () => startBarcodeScanStream(),
                            // ignore: prefer_const_constructors
                            child: Text('Start barcode scan stream')),*/
                        //Tercer pottone que da la posibilidad de volver a la primera página, la de Home Page
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // ignore: prefer_const_constructors
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          // ignore: prefer_const_constructors
                          child: Text('Home Page'),
                          style: TextButton.styleFrom(
                            // ignore: prefer_const_constructors
                            primary: Color.fromARGB(255, 255, 255, 255),
                            // ignore: prefer_const_constructors
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            fixedSize: const Size(180, 40),
                          ),
                        ),
                        /*
                        Texto que se actualiza e imprime el nivigazione o los datos
                        del código QR o del código de barras visual con la cámara
                        trasera del teléfono móvil.
                        */
                        Text(
                          'Scan result : $_scanBarcode\n',
                          // ignore: prefer_const_constructors
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ]));
            })));
  }
}
