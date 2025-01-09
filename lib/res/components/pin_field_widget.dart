// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class RoundedWithShadow extends StatefulWidget {
  const RoundedWithShadow({super.key});

  @override
  _RoundedWithShadowState createState() => _RoundedWithShadowState();
}

class _RoundedWithShadowState extends State<RoundedWithShadow> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 64,
      textStyle:
          const TextStyle(fontSize: 20, color: Color.fromRGBO(70, 69, 66, 1)),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Pinput(
      length: 4,
      controller: controller,
      focusNode: focusNode,
      onCompleted: (String input) {},
      defaultPinTheme: defaultPinTheme.copyWith(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black45))),
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black45))),
      ),
      showCursor: true,
    );
  }
}
