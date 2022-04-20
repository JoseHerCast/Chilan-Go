import 'package:app/screens/navigator_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../data/todo.dart';

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithControllerState createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  String? code;

  MobileScannerController controller = MobileScannerController(
      torchEnabled: false, //deshabilitamos por defecto el flash
      formats: [BarcodeFormat.qrCode] //Solo se detectaran los codigos QR
      // facing: CameraFacing.front,
      );

  bool isStarted = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Todo todos;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            MobileScanner(
                //Widget que controla el scanner del código QR
                controller: controller,
                fit: BoxFit.contain,
                //TODO: Cambiar a false para la versión final
                allowDuplicates:
                    false, //No se permite realizar el scanneo multiples veces dentro de un periodo de tiempo corto
                // controller: MobileScannerController(
                //   torchEnabled: true,
                //   facing: CameraFacing.front,
                // ),
                onDetect: (code, args) {
                  setState(() {
                    //TODO: Aumentar el contador de puntaje acorde a los puntos traidos del
                    var puntaje = int.parse(_parser(code.rawValue, "desc"));
                    //¡Felicidades!, Has obtenido tantos puntos
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: _parser(code.rawValue, "title"),
                      desc: "¡Genial! Has sumado " +
                          _parser(code.rawValue, "desc") +
                          " puntos",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => NavigatorScreen(puntaje: 25)),
                            );
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                    this.code = code.rawValue;
                  });
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: controller.torchState,
                        builder: (context, state, child) {
                          switch (state as TorchState) {
                            case TorchState.off:
                              return const Icon(Icons.flash_off,
                                  color: Colors.grey);
                            case TorchState.on:
                              return const Icon(Icons.flash_on,
                                  color: Colors.yellow);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => controller.toggleTorch(),
                    ),
                    IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: () => setState(() {
                              isStarted
                                  ? controller.stop()
                                  : controller.start();
                              isStarted = !isStarted;
                            })),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            code ?? 'Coloca el código QR',
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: controller.cameraFacingState,
                        builder: (context, state, child) {
                          switch (state as CameraFacing) {
                            case CameraFacing.front:
                              return const Icon(Icons.camera_front);
                            case CameraFacing.back:
                              return const Icon(Icons.camera_rear);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => controller.switchCamera(),
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.image),
                      iconSize: 32.0,
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          if (await controller.analyzeImage(image.path)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Barcode found!'),
                              backgroundColor: Colors.green,
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('No barcode found!'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  String _parser(String? _code, String _property) {
    String response = "";
    if (_property == "title") {
      return _code!.substring(6, _code.indexOf(';'));
    } else {
      return "25";
    }
  }
}
