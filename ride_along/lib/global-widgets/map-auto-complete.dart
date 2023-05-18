//part of flutter_mapbox_autocomplete;

import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ride_along/global-states/drawer.dart';

import '../constants/colors.dart';

class MapAutoCompleteWidget extends StatefulWidget {
  /// Mapbox API_TOKEN

  /// Hint text to show to users
  final String? hint;

  final String? errorText;

  /// Callback on Select of autocomplete result
  final void Function(MapBoxPlace place)? onSelect;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String language;

  /// The point around which you wish to retrieve place information.
  final Location? location;

  /// Limits the no of predections it shows
  final int? limit;

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API
  final String? country;

  bool isDark;

  MapAutoCompleteWidget({
    super.key,
    this.isDark = false,
    this.hint,
    this.onSelect,
    this.language = "en",
    this.location,
    this.limit,
    this.country,
    this.errorText,
  });

  @override
  _MapAutoCompleteWidgetState createState() => _MapAutoCompleteWidgetState();
}

class _MapAutoCompleteWidgetState extends State<MapAutoCompleteWidget> {
  final _searchFieldTextController = TextEditingController();
  final _searchFieldTextFocus = FocusNode();

  Predections? _placePredictions = Predections.empty();

  Future<void> _getPlaces(String input) async {
    if (input.isNotEmpty) {
      String url =
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$input.json?access_token=pk.eyJ1IjoiZnJlZGR5bXVsZXlhMTYiLCJhIjoiY2xlbGtqZTc5MHdiZTN3bXp3MmtmMzNxYSJ9.yYK05x2KDI_BOxzAm0WcvQ&cachebuster=1566806258853&autocomplete=true&language=${widget.language}&limit=${widget.limit}";
      if (widget.location != null) {
        url += "&proximity=${widget.location!.lng}%2C${widget.location!.lat}";
      }
      if (widget.country != null) {
        url += "&country=${widget.country}";
      }
      http.get(Uri.parse(url)).then((response) {
        // print(response.body);
        // // final json = jsonDecode(response.body);
        final predictions = Predections.fromRawJson(response.body);

        _placePredictions = null;

        setState(() {
          _placePredictions = predictions;
        });
      });
    } else {
      setState(() => _placePredictions = Predections.empty());
    }
  }

  void _selectPlace(MapBoxPlace prediction) async {
    // Calls the `onSelected` callback
    widget.onSelect!(prediction);
    _searchFieldTextController.text = prediction.text ?? "";
    setState(() => _placePredictions = Predections.empty());
    print(prediction.toJson());
  }

  bool stop = true;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
          onChanged: (input) async {
            counter++;
            print({"Cluked $counter-", stop});
            if (stop) {
              setState(() {
                stop = false;
              });

              await _getPlaces(input);
              setState(() {
                stop = true;
              });
            }
          },
          focusNode: _searchFieldTextFocus,
          onSubmitted: (value) => _searchFieldTextFocus.unfocus(),
          // suffixIcon: IconButton(
          //   icon: const Icon(Icons.clear),
          //   onPressed: () => _searchFieldTextController.clear(),
          // ),
          controller: _searchFieldTextController,
          textAlign: TextAlign.left,
          style: GoogleFonts.ubuntu(
            color: !widget.isDark ? kTextColorDark : kTextColorLight,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            decorationColor: !widget.isDark ? kTextColorDark : kTextColorLight,
          ),
          cursorColor: !widget.isDark ? kTextColorDark : kTextColorLight,
          //cursorHeight: 35,
          decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isDark
                      ? kBackgroundColor.withOpacity(0.75)
                      : kBackgroundColorDark.withOpacity(0.75),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isDark
                      ? kBackgroundColor.withOpacity(0.75)
                      : kBackgroundColorDark.withOpacity(0.75),
                ),
              ),
              labelStyle: GoogleFonts.ubuntu(
                  color: !widget.isDark
                      ? kBackgroundColorDark.withOpacity(0.75)
                      : kTextColorLight.withOpacity(0.75),
                  fontSize: 14.0),
              hintStyle: GoogleFonts.ubuntu(
                  color: widget.isDark
                      ? kBackgroundColorDark.withOpacity(0.75)
                      : kTextColorLight.withOpacity(0.75),
                  fontSize: 21.0),
              labelText: widget.hint,
              errorText: widget.errorText)),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        //height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (cx, _) => const Divider(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: _placePredictions!.features!.length,
                itemBuilder: (ctx, i) {
                  MapBoxPlace singlePlace = _placePredictions!.features![i];
                  return ListTile(
                    title: Text(singlePlace.text!),
                    subtitle: Text(singlePlace.placeName!),
                    onTap: () => _selectPlace(singlePlace),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
