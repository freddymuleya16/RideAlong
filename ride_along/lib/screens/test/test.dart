import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as mp;
import 'package:ride_along/global-widgets/map-auto-complete.dart';

import 'test2.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City Autocomplete"),
      ),
      body: Column(
        children: [
          MapAutoCompleteWidget(
            language: "en",
            hint: "Enter a city",
            onSelect: (place) {
              // Callback function when a place is selected
              print("${place.placeName}");
            },
          ),
          // AutoCompleteTextField(
          //   options: ["Freddy", "Muleya"],
          // )
        ],
      ),
    );
  }
}
