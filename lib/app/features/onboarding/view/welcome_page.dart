import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 134),
              Center(child: Image.asset('assets/image/app_logo_fill.png')),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Your homeowner loan journey starts here. Let's get you approved!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF373737).withValues(alpha: 0.80),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 154),
              Text(
                "Welcome To Your Customer Portal",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF151515),
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.signup);
                },
                text: "Create Account",
                icon: Icon(Icons.chevron_right, size: 20, color: Colors.white),
              ),

              SizedBox(height: 18),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.login);
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF252525), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252525),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "By continuing, you agree to our Terms & Privacy Policy",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF070707).withValues(alpha: 0.60),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
