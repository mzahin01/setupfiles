// import 'package:flutter/material.dart';
// import 'package:flutter_echarts/flutter_echarts.dart';

// class EChartWidget extends StatelessWidget {
//   const EChartWidget({
//     this.optionScript = '',
//     this.extraScript = '',
//     this.interactive = true,
//     this.height = 286,
//   });

//   final double? height;

//   final String optionScript;
//   final String extraScript;
//   final bool interactive;

//   @override
//   Widget build(BuildContext context) {
//     return AbsorbPointer(
//       absorbing: !interactive,
//       child: SizedBox(
//         width: double.infinity,
//         height: height,
//         child: Echarts(
//           captureAllGestures: false,
//           captureVerticalGestures: false,
//           captureHorizontalGestures: false,
//           option: optionScript,
//           extraScript: extraScript,
//         ),
//       ),
//     );
//   }
// }
