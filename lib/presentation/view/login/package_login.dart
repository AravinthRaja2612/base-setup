
import 'package:flutter/material.dart';




class RajaLoginScreen extends StatefulWidget {
  const RajaLoginScreen({super.key,this.onPressed,this.title});

  final String? title;
  final VoidCallback? onPressed;


  @override
  State<RajaLoginScreen> createState() => _RajaLoginScreenState();
}

class _RajaLoginScreenState extends State<RajaLoginScreen> {

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final isDark = Theme.of(context).brightness == Brightness.dark;



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title??'Login',
          style: textTheme.titleLarge?.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🌈 Welcome Text
              Text(
                'Welcome Back!',
                style: textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please sign in to continue',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // 📧 Email Field
              TextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🔒 Password Field
              TextField(
                controller: TextEditingController(),
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 🔗 Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🚀 Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onPressed ??(){

                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    'Login',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🔒 Biometric Login Button
              // AppButton(buttonText: 'Login with Biometrics',onPressed: viewModel.authenticateUser,),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton.icon(
              //     onPressed: viewModel.authenticateUser,
              //     icon: const Icon(Icons.fingerprint, color: Colors.white),
              //     label: Text(
              //       'Login with Biometrics',
              //       style: textTheme.titleMedium?.copyWith(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(vertical: 14),
              //       backgroundColor: AppColors.secondaryColor(context),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       elevation: 6,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40),

              // 🌗 Theme Indicator
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         isDark ? Icons.dark_mode : Icons.light_mode,
              //         color: Colors.white,
              //       ),
              //       const SizedBox(width: 8),
              //       Text(
              //         isDark ? 'Dark Mode Active' : 'Light Mode Active',
              //         style: textTheme.bodyMedium?.copyWith(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 30),

              // 🧾 Signup Link
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
