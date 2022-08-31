// import 'package:badl_app/modals/preference.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatelessWidget {
//   final List<SubComponent> subComponent;

//   final VoidCallback voidCallback;

//   HomeScreen({
//     required this.subComponent,
//     required this.voidCallback,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimationLimiter(
//         child: ListView.builder(
//           itemCount: 100,
//           itemBuilder: (BuildContext context, int index) {
//             return AnimationConfiguration.staggeredList(
//               position: index,
//               duration: const Duration(milliseconds: 375),
//               child: SlideAnimation(
//                 verticalOffset: 50.0,
//                 child: FadeInAnimation(
//                   child: Container(
//                     color: Colors.pink.withOpacity(0.60),
//                     width: Get.width,
//                     height: 50,
//                     margin: EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
