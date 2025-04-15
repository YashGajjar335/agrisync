import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LongButton extends StatelessWidget {
  final double? width;
  final String buttonText;
  final bool isLoading;
  final IconData? icon;
  final double? fontSize;
  final void Function() onTap;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final double elevation;

  const LongButton({
    super.key,
    this.width,
    required this.buttonText,
    required this.onTap,
    this.isLoading = false,
    this.icon,
    this.fontSize,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width ?? double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: gradient ??
                LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              if (elevation > 0)
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: elevation,
                  offset: const Offset(2, 4),
                ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: iconColor ?? Colors.white, size: 24),
                        const SizedBox(width: 8),
                      ],
                      Container(
                        // width: width ?? 300,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              buttonText,
                              style: GoogleFonts.lato(
                                fontSize: fontSize ?? 20,
                                fontWeight: FontWeight.bold,
                                color: textColor ?? Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
