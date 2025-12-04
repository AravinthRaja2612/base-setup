import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';
import 'package:flutter_learn/presentation/utils/design_utils.dart';
import 'package:flutter_learn/presentation/view/login/package_login.dart';
import 'package:flutter_learn/presentation/viewmodel/login/login_viewmodel.dart';
import 'package:provider/provider.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    

    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginViewModel()..init(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.surfaceColor(context),
          title: Text(
            'Login',
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.primaryColor(context),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<LoginViewModel>(
          builder: (BuildContext context, LoginViewModel viewModel, Widget? child) {

            final state = viewModel.state;

            if (state.errorMessage != null) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            return  Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🌈 Welcome Text
                    Text(
                      'Welcome Back!',
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please sign in to continue',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondaryColor(context),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 📧 Email Field
                    TextField(
                      controller: viewModel.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.primaryColor(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🔒 Password Field
                    TextField(
                      controller: viewModel.passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.primaryColor(context),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondaryColor(context),
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RajaLoginScreen()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryColor(context),
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
                        onPressed: viewModel.handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primaryColor(context),
                          foregroundColor: AppColors.backgroundColor(context),
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
                    AppButton(buttonText: 'Login with Biometrics',onPressed: viewModel.authenticateUser,),
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                            color: AppColors.primaryColor(context),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isDark ? 'Dark Mode Active' : 'Light Mode Active',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🧾 Signup Link
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryColor(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }



}
