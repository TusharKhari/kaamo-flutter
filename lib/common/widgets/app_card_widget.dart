import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class AppCardWidget extends StatelessWidget {
  final Widget child;
  const AppCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      // shadowColor: Colors.black,
      shadowColor: logoImageColor,
      elevation: 7,
      surfaceTintColor: Colors.grey[300], child: child,
    );
  }
}
