// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ride_along/constants/colors.dart';
// import 'package:ride_along/models/tasks.dart';

// class RemoveAllTasksDialog extends StatelessWidget {
//   bool _isDark = false;
//   @override
//   Widget build(BuildContext context) {
//     final Brightness brightnessValue =
//         MediaQuery.of(context).platformBrightness;
//     _isDark = brightnessValue == Brightness.dark;
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return AlertDialog(
//           backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Text(
//             "Are you sure?",
//             style: GoogleFonts.ubuntu(
//                 fontSize: 22.5,
//                 fontWeight: FontWeight.w600,
//                 color: _isDark ? kBackgroundColor : kBackgroundColorDark),
//           ),
//           content: Text(
//             "All tasks will be deleted.",
//             style: GoogleFonts.ubuntu(
//                 fontSize: 17.5,
//                 fontWeight: FontWeight.w500,
//                 color: _isDark
//                     ? kBackgroundColor.withOpacity(0.8)
//                     : kBackgroundColorDark.withOpacity(0.8)),
//           ),
//           actions: [
//             TextButton(
//               child: Text(
//                 "Cancel",
//                 style: GoogleFonts.ubuntu(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: _isDark
//                         ? kBackgroundColor.withOpacity(0.9)
//                         : kBackgroundColorDark),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text(
//                 "Delete",
//                 style: GoogleFonts.ubuntu(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.redAccent),
//               ),
//               onPressed: () {
//                 removeAllTasks();
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
