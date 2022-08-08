// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../style.dart';

// class SnackBarClass extends StatelessWidget {
//   const SnackBarClass({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         action: SnackBarAction(
//           label: 'Action',
//           onPressed: () {
//             // Code to execute.
//             ScaffoldMessenger.of(context).clearSnackBars();
//           },
//         ),
//         content: const Text(
//           'Awesome SnackBar!',
//           style: Style.caption,
//         ),
//         duration: const Duration(seconds: 50),
//         width: Get.width / 1.10, // Width of the SnackBar.
//         padding: const EdgeInsets.symmetric(
//           horizontal: 8.0, // Inner padding for SnackBar content.
//         ),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//     );
//   }
// }
