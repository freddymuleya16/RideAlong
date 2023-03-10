import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as mp;
import "package:intl/intl.dart" show DateFormat;
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/models/trip.dart';

import '../../constants/colors.dart';
import '../../global-widgets/custom-input-field.dart';
import '../../global-widgets/map-auto-complete.dart';
import 'controllers/create-trip-controller.dart';

class CreateNewTripPage extends StatefulWidget {
  ///TripService tripService = serviceLocator.get<TripService>();
  CreateNewTripPage({super.key});

  @override
  State<CreateNewTripPage> createState() => _CreateNewTripPageState();
}

class MyController {
  final controller = TextEditingController();
  String? _errorText;
}

class _CreateNewTripPageState extends State<CreateNewTripPage> {
  int currentStep = 0;
  bool _isDark = false;
  var price = MyController();
  var origin = MyController();
  var destination = MyController();
  var date = MyController();
  var seats = MyController();
  var duration = MyController();
  var numberOfStops = MyController();
  var make = MyController();
  var plate = MyController();
  var model = MyController();
  var color = MyController();
  DateTime dateTime = DateTime.now();
  var styles = {};
  mp.MapBoxPlace? originPlace;
  mp.MapBoxPlace? destinationPlace;

  @override
  Widget build(BuildContext context) {
    //var tripService = serviceLocator.get<TripService>();
    _isDark = isDark(context);
    styles = {
      'bold': GoogleFonts.ubuntu(
        fontSize: 15,
        color: _isDark ? kBackgroundColor : Colors.black,
        fontWeight: FontWeight.w700,
      ),
      'normal': GoogleFonts.ubuntu(
        fontSize: 15,
        color: _isDark ? kBackgroundColor : Colors.black,
      )
    };
    return Container(
      decoration: BoxDecoration(
        color: _isDark ? kDarkBackgroundColor2 : kBackgroundColor,
      ),
      width: double.maxFinite,
      child: Stepper(
        controlsBuilder: (context, details) {
          return Wrap(direction: Axis.vertical, children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                details.stepIndex == getSteps().length - 1
                    ? TextButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: _isDark
                                        ? Colors.white
                                        : kSecondaryColor,
                                  ),
                                );
                              });
                          var trip = Trip(
                              car: Car(
                                  color: color.controller.text,
                                  make: make.controller.text,
                                  model: model.controller.text,
                                  licensePlate: plate.controller.text),
                              id: "",
                              driverId: FirebaseAuth.instance.currentUser!.uid,
                              startTime: dateTime,
                              passengerIds: [],
                              rejectedPassengerIds: [],
                              requestedPassengerIds: [],
                              availableSeats:
                                  int.parse(seats.controller.value.text),
                              endLocation: destination.controller.value.text,
                              startLocation: origin.controller.value.text,
                              duration: duration.controller.value.text,
                              status: TripStatus.pending,
                              price: double.parse(price.controller.value.text),
                              destinationPlace: destinationPlace,
                              originPlace: originPlace);
                          var res = await TripController.createTrip(trip);
                          //Navigator.pop(context);

                          if (res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Trip has been created successfully')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Ooops something went wrong. please try again')));
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          if (validated(details.stepIndex)) {
                            details.onStepContinue!();
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                details.currentStep == 0
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Exit',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          details.onStepCancel!();
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
              ],
            ),
          ]);
        },
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: (() {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            //save data
          }
          setState(() => currentStep++);
        }),
        onStepCancel: () {
          if (currentStep == 0) {
            //close
            return;
          }
          setState(() => currentStep--);
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text(
            'Origin',
            style: styles['bold'],
          ),
          content: Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Where will you be departing from?',
                    style: styles['normal']),
                const SizedBox(
                  height: 20,
                ),
                MapAutoCompleteWidget(
                  isDark: _isDark,
                  errorText: origin._errorText,
                  //controller: origin.controller,
                  hint: 'Origin(e.g Johannesburg)',
                  language: 'en',
                  limit: 6,
                  onSelect: (place) {
                    origin.controller.text = place.text!;
                    originPlace = place;
                  },
                ),
                // CustomInputField(
                //     isDark: _isDark,
                //     errorText: origin._errorText,
                //     controller: origin.controller,
                //     name: 'Origin(e.g Johannesburg)'),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text('Destination', style: styles['bold']),
          content: Column(
            children: [
              Text('Where is your final destination?', style: styles['normal']),
              const SizedBox(
                height: 20,
              ),
              MapAutoCompleteWidget(
                isDark: _isDark,
                errorText: destination._errorText,
                //controller: destination.controller,
                hint: 'Destination(e.g Johannesburg)',
                language: 'en',
                //limit: 6,
                onSelect: (place) {
                  destination.controller.text = place.text!;
                  destinationPlace = place;
                },
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Date', style: styles['bold']),
          content: Column(
            children: [
              Text('When do you plan to travel?', style: styles['normal']),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                  isDark: _isDark,
                  onTap: PickDateTime,
                  isReadOnly: true,
                  errorText: date._errorText,
                  controller: date.controller,
                  name: 'Date'),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 3,
          title: Text('Pricing', style: styles['bold']),
          content: Container(
            child: Column(
              children: [
                Text('Whats your price?', style: styles['normal']),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: price._errorText,
                    controller: price.controller,
                    name: 'Price (R)'),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 4,
          title: Text('Additional Details', style: styles['bold']),
          content: Container(
            child: Column(
              children: [
                Text('Please give Addtional information on the trip',
                    style: styles['normal']),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: seats._errorText,
                    controller: seats.controller,
                    name: 'Seats available'),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: duration._errorText,
                    controller: duration.controller,
                    name: 'Estimated duration'),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: numberOfStops._errorText,
                    controller: numberOfStops.controller,
                    name: 'Number of stops'),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 5,
          title: Text('Car details', style: styles['bold']),
          content: Container(
            child: Column(
              children: [
                Text('Please give information on the car for the trip',
                    style: styles['normal']),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: make._errorText,
                    controller: make.controller,
                    name: 'Make'),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: model._errorText,
                    controller: model.controller,
                    name: 'Model'),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: color._errorText,
                    controller: color.controller,
                    name: 'Color'),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                    isDark: _isDark,
                    errorText: plate._errorText,
                    controller: plate.controller,
                    name: 'Number plate'),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 6,
          title: Text('Summary', style: styles['bold']),
          content: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text('Summary', style: styles['bold']),
                const SizedBox(
                  height: 20,
                ),
                Text('Origin: ${origin.controller.text}',
                    style: styles['normal']),
                const SizedBox(
                  height: 10,
                ),
                Text('Destination: ${destination.controller.text}',
                    style: styles['normal']),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Car Model: ${color.controller.text} ${make.controller.text} ${model.controller.text}',
                    style: styles['normal']),
                const SizedBox(
                  height: 10,
                ),
                Text('Number plate: ${plate.controller.text}',
                    style: styles['normal']),
                const SizedBox(
                  height: 10,
                ),
                Text('Date: ${date.controller.text}', style: styles['normal']),
                const SizedBox(
                  height: 10,
                ),
                Text('Price: R${price.controller.text}',
                    style: styles['normal']),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ];

  Future PickDateTime() async {
    try {
      final date = await PickDate();
      if (date == null) return;

      final time = await PickTime();
      if (time == null) return;

      setState(() {
        dateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);

        this.date.controller.text =
            DateFormat("HH'h'mm d MMM y", 'en_US').format(dateTime);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DateTime?> PickDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2100));

    if (date == null) return null;

    return date;
  }

  Future<TimeOfDay?> PickTime() async {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

    return time;
  }

  bool validated(int step) {
    switch (step) {
      case 0:
        origin._errorText = null;
        if (origin.controller.value.text.isEmpty == true) {
          setState(() => origin._errorText = 'Required');
          return false;
        }
        if (originPlace == null) {
          setState(() => origin._errorText = 'Please select a place');
          return false;
        }

        break;
      case 1:
        destination._errorText = null;
        if (destination.controller.value.text.isEmpty == true) {
          setState(() => destination._errorText = 'Required');
          return false;
        }
        if (destinationPlace == null) {
          setState(() => destination._errorText = 'Please select a place');
          return false;
        }
        break;
      case 2:
        date._errorText = null;
        if (date.controller.value.text.isEmpty == true) {
          setState(() => date._errorText = 'Required');
          return false;
        } else if (dateTime.isBefore(DateTime.now())) {
          setState(() => date._errorText = 'Date has already passed');
          return false;
        }
        break;
      case 3:
        price._errorText = null;
        if (price.controller.value.text.isEmpty == true) {
          setState(() => price._errorText = 'Required');
          return false;
        } else if (double.tryParse(price.controller.value.text) == null) {
          setState(() => price._errorText = 'Numeric value only');
          return false;
        }
        break;
      case 4:
        duration._errorText = null;
        seats._errorText = null;
        numberOfStops._errorText = null;
        if (seats.controller.value.text.isEmpty == true) {
          setState(() => seats._errorText = 'Required');
          return false;
        } else if (double.tryParse(seats.controller.value.text) == null) {
          setState(() => seats._errorText = 'Numeric value only');
          return false;
        }

        if (duration.controller.value.text.isEmpty == true) {
          setState(() => duration._errorText = 'Required');
          return false;
        } else if (!RegExp(r'\d+(Hr){1}s?(\s{1}\d+(Min){1})?s?$')
            .hasMatch(duration.controller.value.text)) {
          setState(
              () => duration._errorText = 'Invalid format (e.g 3Hrs 10Mins)');
          return false;
        }

        if (numberOfStops.controller.value.text.isEmpty == true) {
          setState(() => numberOfStops._errorText = 'Required');
          return false;
        } else if (double.tryParse(numberOfStops.controller.value.text) ==
            null) {
          setState(() => numberOfStops._errorText = 'Numeric value only');
          return false;
        }
        break;
      case 5:
        make._errorText = null;
        model._errorText = null;
        color._errorText = null;
        plate._errorText = null;

        if (make.controller.value.text.isEmpty == true) {
          setState(() => make._errorText = 'Required');
          return false;
        }

        if (model.controller.value.text.isEmpty == true) {
          setState(() => model._errorText = 'Required');
          return false;
        }

        if (color.controller.value.text.isEmpty == true) {
          setState(() => color._errorText = 'Required');
          return false;
        }
        if (plate.controller.value.text.isEmpty == true) {
          setState(() => plate._errorText = 'Required');
          return false;
        }
        break;
      default:
    }
    return true;
  }
}
