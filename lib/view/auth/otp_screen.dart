import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/auth_view_model.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  Timer? _timer;
  int _remainingTime = 60;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = 60;
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  bool _canResendOtp(AuthenticationViewModel otpProvider) =>
      !_isRunning &&
          !otpProvider.otpLoading &&
          controller.text.isEmpty &&
          otpProvider.verifyMessage == null ||
      otpProvider.errorMessage == null;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? phone = args['phone'];
    final otpProvider = Provider.of<AuthenticationViewModel>(context);

    const defaultPinTheme = PinTheme(
      width: 50,
      height: 64,
      textStyle: TextStyle(fontSize: 20, color: Colors.black87),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black45))),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          logoContainer(),
          paddingContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: 'नमस्ते',
                    color: AppColors.lastButtonColor,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.twentyFour),
                SpaceHeight.getZeroTwo(context),
                textWidget(
                    text:
                        'Welcome to FundaMakers Community. Enter your mobile number to register with us.',
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.sixteen),
                SpaceHeight.getZeroTwo(context),
                Center(
                  child: Pinput(
                    length: 4,
                    controller: controller,
                    focusNode: focusNode,
                    onCompleted: (String input) {
                      // Optional: Handle completed input here
                    },
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black45))),
                    ),
                    showCursor: true,
                  ),
                ),
                Visibility(
                  visible: otpProvider.verifyMessage != null ||
                      otpProvider.errorMessage != null,
                  child: Center(
                    child: textWidget(
                      textAlign: TextAlign.center,
                      text: otpProvider.verifyMessage ??
                          otpProvider.errorMessage ??
                          '',
                      fontSize: Dimensions.fifteen,
                      color: AppColors.lightRedColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SpaceHeight.getZeroTwo(context),
                textWidget(
                    text:
                        'Please enter the 4-digit code sent to your mobile number via SMS.',
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.sixteen),
                SpaceHeight.getZeroTwo(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      onTap: () {
                        if (_canResendOtp(otpProvider)) {
                          otpProvider.otpSentApi(phone!, context);
                          _startTimer();
                          otpProvider.clearErrors();
                        }
                      },
                      text: 'Resend OTP',
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.sixteen,
                      color: !_isRunning
                          ? AppColors.lightRedColor
                          : AppColors.lightRedColor.withAlpha(40),
                    ),
                    textWidget(
                        text: '0:$_remainingTime',
                        fontWeight: FontWeight.w600,
                        color: AppColors.textButtonColor,
                        fontSize: Dimensions.sixteen),
                  ],
                ),
                SpaceHeight.getZeroTwo(context),
                AppBtn(
                  loading: otpProvider.verifyLoading,
                  onTap: () {
                    otpProvider.verifyOtpApi(phone!, controller.text, context);
                  },
                  title: 'Confirm and Continue',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
