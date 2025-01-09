import 'package:flutter/material.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBtn extends StatefulWidget {
  final String? title;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? loading;
  final Gradient? gradient;

  const AppBtn({
    Key? key,
    this.title,
    this.onTap,
    this.width,
    this.height,
    this.fontSize,
    this.gradient,
    this.loading = false,
  }) : super(key: key);

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Center(
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                height: widget.height??45,
                width: widget.width ?? MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient:widget.gradient?? const LinearGradient(
                    colors: [
                      AppColors.gradientFirstColor,
                      AppColors.gradientSecondColor,
                    ],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topRight,
                    end: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: widget.loading == true
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  widget.title ?? 'Press me',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(
                      color: AppColors.themeWhiteColor,
                      fontSize: widget.fontSize ?? 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppBackBtn extends StatelessWidget {
  const AppBackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.gradientFirstColor,
              AppColors.gradientSecondColor,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({
    Key? key,
    required this.onTap,
    this.btnColor = Colors.black,
  }) : super(key: key);

  final Function() onTap;
  final Color? btnColor;

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.arrow_back_ios,
          color: widget.btnColor,
        ),
      ),
    );
  }
}
