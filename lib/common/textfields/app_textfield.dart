import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  const AppTextField(
      {super.key,
      this.controller,
      this.onChanged,
      this.suffix,
      this.focusNode,
      this.hintText,
      this.labelText,
      this.obscureText,
      this.validator,
      this.inputFormatters,
      this.keyboardType,
      this.padding, this.autofocus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        autofocus: autofocus??false,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        cursorColor: Colors.grey.shade400,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffix: suffix,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
