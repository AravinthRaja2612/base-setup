import 'package:flutter/material.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';

class AppButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String? buttonText;

  const AppButton({super.key,this.onPressed,this.buttonText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed??() {},
        icon: const Icon(Icons.fingerprint, color: Colors.white),
        label: Text(
          buttonText??'Login with Biometrics',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: AppColors.secondaryColor(context).withAlpha((300*0.4).toInt()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      ),
    );

  }
}
