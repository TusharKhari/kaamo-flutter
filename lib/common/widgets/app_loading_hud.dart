import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AppLoadingHud extends StatelessWidget {
  final bool isAsyncCall;
  final Widget child;
  const AppLoadingHud(
      {super.key, required this.isAsyncCall, required this.child});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.transparent,
      progressIndicator: LoadingAnimationWidget.discreteCircle(
        color: Colors.white,
        size: 60,
      ),
      inAsyncCall: isAsyncCall,
      child: child,
    );
  }
}
