import 'package:flutter/material.dart';

class OutLinedButton extends StatelessWidget {
  final IconData icons;
  final Function() onPress;
  const OutLinedButton({super.key, required this.icons, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ), // Add padding
        ),
        onPressed: onPress,
        child: Icon(icons),
      ),
    );
  }
}
