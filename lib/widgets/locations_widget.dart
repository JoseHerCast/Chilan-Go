import 'package:app/data/locations.dart';
import 'package:app/style/my_colors.dart';
import 'package:app/widgets/icon_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'location_widget.dart';

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [
            /*Logros y puntaje*/
            Container(
              //color: Colors.green,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconProgress(
                    value: '0',
                    iconPath: 'assets/icons/trophy.png',
                    type: "back",
                  ),
                  IconProgress(
                    value: '0',
                    iconPath: 'assets/icons/bag.png',
                    type: "al",
                  )
                ],
              ),
            ),
            /*Rango*/
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];

                  return LocationWidget(location: location);
                },
                onPageChanged: (index) => setState(() => pageIndex = index),
              ),
            ),
            Text(
              '${pageIndex + 1}/${locations.length}',
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(height: 12)
          ],
        ),
      );
}
