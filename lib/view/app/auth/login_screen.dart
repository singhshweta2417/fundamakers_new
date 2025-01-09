import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/providers/auth/otp_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_text_field.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNo = TextEditingController();
  TextEditingController passNo = TextEditingController();

  bool _isChecked = false;
  String? _phoneError;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final otpScreenProvider = Provider.of<OtpScreenProvider>(context);
    bool showPhoneErrorContainer = false;
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
              SizedBox(
                height: height * 0.01,
              ),
              textWidget(
                  text:
                      'Welcome to FundaMakers Community.Enter your\nmobile number to register with us.',
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.sixteen),
              showPhoneErrorContainer == false
                  ? Consumer<OtpScreenProvider>(
                      builder: (context, otpScreenProvider, child) {
                        return Visibility(
                          visible: otpScreenProvider.errorMessage != null,
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.07,
                            width: width,
                            color: AppColors.lastButtonColor,
                            child: Text(
                              otpScreenProvider.errorMessage ?? 'Login Failed',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      height: height * 0.08,
                    ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: phoneNo,
                    width: width * 0.8,
                    hintText: 'Enter Mobile Number',
                    borderSide: const BorderSide(color: Colors.transparent),
                    border: const Border(
                      bottom: BorderSide(width: 1, color: AppColors.blackColor),
                    ),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: width * 0.02),
                        child: SizedBox(
                          width: width * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image:
                                    const AssetImage(Assets.imagesCountryFlag),
                                width: width * 0.06,
                              ),
                              textWidget(text: '+91'),
                              const VerticalDivider(
                                color: AppColors.blackColor,
                                indent: 7,
                                endIndent: 7,
                              )
                            ],
                          ),
                        )),
                  ),
                  if (phoneNo.text.length != 10 && _phoneError != null)
                    Text(
                      _phoneError!.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    activeColor: AppColors.themeGreenColor,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: width * 0.75,
                    child: RichText(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'By creating an account,you agree to our ',
                        style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black)),
                        children: const [
                          TextSpan(
                              text: 'Terms of Service ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textButtonColor)),
                          TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textButtonColor)),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textButtonColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.5),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.registerScreen);
                  },
                  child: textWidget(
                      text: 'New to fundamakers?',
                      color: AppColors.lastButtonColor,
                      fontSize: Dimensions.thirteen),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              AppBtn(
                loading: otpScreenProvider.loading,
                onTap: () {
                  if (phoneNo.text.isEmpty || phoneNo.text.length != 10) {
                    setState(() {
                      _phoneError =
                          'Please enter a valid 10-digit phone number';
                    });
                  } else if (_isChecked == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.greyColor,
                        content: Text(
                            'Please agree to the Terms of Service and Privacy Policy'),
                      ),
                    );
                  } else {
                    _phoneError = null;
                    otpScreenProvider.sendOtpOnPhone(context, phoneNo.text);
                  }
                },
                title: 'Login with OTP',
              ),
            ],
          ))
        ],
      ),
    );
  }
}
