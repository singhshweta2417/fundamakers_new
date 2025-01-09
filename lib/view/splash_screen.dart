import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/services/splash_services.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false;
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
    Future.delayed(const Duration(microseconds: 700), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              top: mq.height * .20,
              left: _isAnimate ? mq.width * .0 : -mq.width * .06,
              duration: const Duration(seconds: 2),
              child: Container(
                height: height * 0.5,
                width: width * 0.999,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(Assets.imagesFundamakersSplash),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10)),
              )),
          AnimatedPositioned(
              top: mq.height * .27,
              right: _isAnimate ? mq.width * .08 : -mq.width * .06,
              width: mq.width * .35,
              duration: const Duration(seconds: 2),
              child: SizedBox(
                width: width * 0.02,
                // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Best ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.themeGreenColor),
                        ),
                        SizedBox(
                          // color: Colors.blue,
                          height: height * 0.04,
                          width: width * 0.15,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText(
                                'CAT',
                              ),
                              RotateAnimatedText('CUET',
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      color: AppColors.textButtonColor,
                                      fontWeight: FontWeight.w700)),
                              RotateAnimatedText('IPMAT',
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      color: AppColors.textButtonColor,
                                      fontWeight: FontWeight.w700)),
                            ],
                            onTap: () {
                              if (kDebugMode) {
                                print("Tap Event");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                      width: width * 0.35,
                      child: const Text(
                        'Coaching ',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.themeGreenColor),
                      ),
                    ),
                  ],
                ),
              )),
          AnimatedPositioned(
              right: mq.width * .3,
              bottom: _isAnimate ? mq.height * .18 : -mq.height * .09,
              duration: const Duration(seconds: 2),
              child: Container(
                height: height * 0.07,
                width: width * 0.35,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.logoFundamakers),
                        fit: BoxFit.fill)),
              )),
        ],
      ),
    );
  }
}
