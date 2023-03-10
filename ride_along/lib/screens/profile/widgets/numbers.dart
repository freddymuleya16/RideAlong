import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  final int numberOfTrips;
  final double rating;
  final double totalDistance;
  const NumbersWidget(
      {super.key,
      required this.numberOfTrips,
      required this.rating,
      required this.totalDistance});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, rating.toStringAsFixed(1), 'Rating'),
          buildDivider(),
          buildButton(context, numberOfTrips.toString(), 'Trips'),
          buildDivider(),
          buildButton(context, totalDistance.toString(), 'Total distance'),
        ],
      );
  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
