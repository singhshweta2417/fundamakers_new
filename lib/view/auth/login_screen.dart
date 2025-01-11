import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_text_field.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/auth_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNo = TextEditingController();

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
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
                      'Welcome to FundaMakers Community.Enter your\nmobile number to register with us.',
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.sixteen),
              SpaceHeight.getZeroTwo(context),
              customTextFormField(
                isBottomBorderOnly: true,
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phoneNo,
                hintText: 'Enter Mobile Number',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: width * 0.02),
                  child: SizedBox(
                    width: width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: const AssetImage(Assets.imagesCountryFlag),
                          width: width * 0.07,
                        ),
                        textWidget(text: '+91'),
                        verticalBorder(color: Colors.black)
                      ],
                    ),
                  ),
                ),
                errorText: otpProvider.errorMessage?.isEmpty ?? true
                    ? null
                    : otpProvider.errorMessage,
              ),
              SpaceHeight.getZeroTwo(context),
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
              SpaceHeight.getZeroTwo(context),
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
              SpaceHeight.getZeroTwo(context),
              AppBtn(
                loading: otpProvider.otpLoading,
                onTap: () {
                  if (_isChecked == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.greyColor,
                        content: Text(
                            'Please agree to the Terms of Service and Privacy Policy'),
                      ),
                    );
                  } else {
                    otpProvider.otpLoading
                        ? null
                        : otpProvider.otpSentApi(
                            phoneNo.text.toString(), context);
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
