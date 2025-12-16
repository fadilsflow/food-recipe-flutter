import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<AuthProvider>().register(
              _nameController.text,
              _emailController.text,
              _passwordController.text,
            );
        if (!mounted) return;
        // After register, auto-login usually happens in provider, so navigate home or back to login?
        // My provider code auto-logs in.
        // But usually UX is "Registration Successful, please login" or auto-redirect.
        // Provider does:  _currentUser = user; so it's logged in.
        // Let's redirect to Login just to be safe or show success message then login.
        // Actually, let's navigate to LoginPage so user can login properly or since provider sets user, maybe home? 
        // Docs say Register response gives token. So we are logged in.
        // However, standard flow: Register -> Login (sometimes).
        // Let's go to Login Page to be explicit and less confusing, or Back.
        // But since I updated AuthProvider to potentially set state, let's just pop or go to Login.
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())); 
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful! Please Login."),
            backgroundColor: Colors.green,
          ),
        );

      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: const Icon(Icons.person_add, size: 70, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
					  delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 800),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: CustomTextField(
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        controller: _nameController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: CustomTextField(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: CustomTextField(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      child: Consumer<AuthProvider>(
                        builder: (context, auth, _) {
                          return PrimaryButton(
                            text: 'Register',
                            isLoading: auth.isLoading,
                            onPressed: _handleRegister,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: AppTheme.bodyMedium),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
