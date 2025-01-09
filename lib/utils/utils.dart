import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/res/app_colors.dart';

class ShowMessages {
  static void showErrorSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.lightRedColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Oh snap!",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: Image(
                  height: 50,
                  width: 40,
                  image: AssetImage(Assets.iconsBubbleIcon),
                  color: AppColors.lastButtonColor,
                ),
              ),
            ),
            const Positioned(
              top: -15,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    height: 48,
                    image: AssetImage(Assets.iconsDropIcon),
                    color: AppColors.lastButtonColor,
                  ),
                  Positioned(
                    top: 8,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
  static void showSuccessSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Success!",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: Image(
                  height: 50,
                  width: 40,
                  image: AssetImage(Assets.iconsBubbleIcon),
                  color: AppColors.themeGreenColor,
                ),
              ),
            ),
            const Positioned(
              top: -15,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    height: 48,
                    image: AssetImage(Assets.iconsDropIcon),
                    color: AppColors.themeGreenColor,
                  ),
                  Positioned(
                    top: 8,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
