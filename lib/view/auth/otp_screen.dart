import 'package:flutter/material.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/auth_view_model.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

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
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? phone = args['phone'];
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
    final otpProvider = Provider.of<AuthenticationViewModel>(context);
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
                        'Welcome to FundaMakers Community.Enter your mobile number to register with us.',
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.sixteen),
                SpaceHeight.getZeroTwo(context),
                Center(
                  child: Pinput(
                    length: 4,
                    controller: controller,
                    focusNode: focusNode,
                    onCompleted: (String input) {},
                    defaultPinTheme: defaultPinTheme.copyWith(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black45))),
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black45))),
                    ),
                    showCursor: true,
                  ),
                ),
                otpProvider.verifyMessage != null
                    ? Center(
                        child: Consumer<AuthenticationViewModel>(
                          builder: (context, otpProvider, child) {
                            return Visibility(
                                visible: otpProvider.verifyMessage != null,
                                child: textWidget(
                                    textAlign: TextAlign.center,
                                    text: otpProvider.verifyMessage ??
                                        'Login Failed',
                                    fontSize: Dimensions.fifteen,
                                    color: AppColors.lightRedColor,
                                    fontWeight: FontWeight.w500));
                          },
                        ),
                      )
                    : Container(),
                SpaceHeight.getZeroTwo(context),
                textWidget(
                    text:
                        'Please enter 4 digit code we sent on your mobile number as SMS',
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.sixteen),
                SpaceHeight.getZeroTwo(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: 'Resend OTP',
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.sixteen,
                        color: AppColors.lightRedColor),
                    textWidget(
                        text: '0:50',
                        fontWeight: FontWeight.w600,
                        color: AppColors.textButtonColor,
                        fontSize: Dimensions.sixteen)
                  ],
                ),
                SpaceHeight.getZeroTwo(context),
                AppBtn(
                  loading: otpProvider.verifyLoading,
                  onTap: () {
                    otpProvider.verifyOtpApi(
                        phone.toString(), controller.text, context);
                    if (controller.text.isNotEmpty) {
                    } else {}
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
