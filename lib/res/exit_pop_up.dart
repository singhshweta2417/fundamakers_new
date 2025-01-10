import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/text_widget.dart';

Future<bool?> showBackDialog({
  required BuildContext context,
  String message = 'Are You Sure You want to Exit?',
  required VoidCallback yes,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          height: height * 0.2,
          decoration: BoxDecoration(
            color: AppColors.themeWhiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textWidget(text: message, fontSize: Dimensions.eighteen),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBtn(
                      height: height * 0.05,
                      onTap: yes,
                      width: width * 0.25,
                      title: 'Yes',),
                  AppBtn(
                    height: height * 0.05,
                    width: width * 0.25,
                    title: 'No',
                    onTap: () {
                      HapticFeedback.vibrate();
                      Navigator.pop(context);
                      SystemSound.play(SystemSoundType.click);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
