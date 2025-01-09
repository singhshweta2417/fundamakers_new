// import 'package:flutter/material.dart';
// import 'package:fundamakers/generated/assets.dart';
// import 'package:fundamakers/main.dart';
// import 'package:fundamakers/providers/auth/forget_password_provider.dart';
// import 'package:fundamakers/res/app_colors.dart';
// import 'package:fundamakers/res/components/app_btn.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
//
// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({super.key});
//
//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }
//
// class _ForgetPasswordState extends State<ForgetPassword> {
//
//
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmPassCon = TextEditingController();
//   String? _passwordError;
//   String? _cPasswordError;
//   @override
//   Widget build(BuildContext context) {
//    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.green,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(width * 0.26, 0, 0, 0),
//             child: Container(
//               height: height * 0.10,
//               width: width * 0.5,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(Assets.logoFundamakers))),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 top: height * 0.13,
//               ),
//               child: Container(
//                 height: height * 0.9,
//                 width: width,
//                 decoration: BoxDecoration(
//                     color: AppColors.themeWhiteColor,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(width * 0.3))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: height * 0.12,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: width * 0.72),
//                       child: Text(
//                         'नमस्ते',
//                         style: GoogleFonts.robotoCondensed(
//                           textStyle: const TextStyle(
//                               color: AppColors.lastButtonColor,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 25),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Welcome to FundaMakers Community. Enter your\nmobile number to register with us.',
//                       style: GoogleFonts.robotoCondensed(
//                           textStyle: const TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 17)),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//
//                     Padding(
//                       padding: EdgeInsets.only(right: width * 0.68),
//                       child: const Text('Password:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     SizedBox(
//                       height: _passwordError != null ? height * 0.09 : height * 0.06,
//                       width: width * 0.87,
//                       child: TextField(
//                         controller: password,
//                         keyboardType: TextInputType.text,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock_open_outlined, size: 20),
//                           hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                           hintText: 'Password',
//                           border: const OutlineInputBorder(),
//                           errorText: _passwordError,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: width * 0.52),
//                       child: const Text('Confirm Password:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     SizedBox(
//                       height: _cPasswordError != null ? height * 0.09 : height * 0.06,
//                       width: width * 0.87,
//                       child: TextField(
//                         controller: confirmPassCon,
//                         keyboardType: TextInputType.text,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock_outline, size: 20),
//                           hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                           hintText: 'Confirm Password',
//                           border: const OutlineInputBorder(),
//                           errorText: _cPasswordError,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     AppBtn(
//                       width: width * 0.85,
//                       onTap: () {
//                         changePasswordProvider.userChangePassword(context, password.text, confirmPassCon.text);
//                       },
//                       title: 'Confirm',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
