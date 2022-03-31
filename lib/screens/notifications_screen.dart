import 'package:app/style/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: ListView(
        children: [
          Column(
            children: const [
              NotificationCard(
                message:
                    "Recibiste una recompensa por escanear el código QR de Vallejo-i",
                image: "assets/icons/gift.png",
              ),
              NotificationCard(
                message:
                    "¿Ya visitaste el Monumento al Arqueólogo José Antonio Urdapilleta Pérez?, ¡esta muy cerca de ti!",
                image: "assets/icons/place.png",
              ),
              NotificationCard(
                message:
                    "¡No olvides escanear los códigos QR de tus lugares favoritos!",
                image: "assets/icons/notification.png",
              ),
              NotificationCard(
                message:
                    "Recibiste una recompensa por subir de nivel: ¡10% de descuento en tu próxima visita al Sumoaya!",
                image: "assets/icons/gift.png",
              ),
              NotificationCard(
                message:
                    "!Recuerda utilizar las recompensas que ganas durante tu exploración de la CDMX!",
                image: "assets/icons/notification.png",
              ),
              NotificationCard(
                message:
                    "Recibiste una recompensa por subir escanear 120 codigos QR: ¡Nuevo avatar desbloqueado!",
                image: "assets/icons/gift.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.message,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String message;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.mainBlue,
            child: Image.asset(
              image,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(message),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 20,
                  ),
                  child: Text(
                    DateFormat.yMMMd().add_Hms().format(DateTime.now()) +
                        " hrs.",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
