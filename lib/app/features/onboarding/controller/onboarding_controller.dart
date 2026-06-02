import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;
  final _storage = StorageService();

  static const pages = [
    OnboardingItem(
      imagePath: 'assets/image/onboarding.jpg',
      title: 'Fast & Secure Loans',
      description:
          'Get approved quickly with our streamlined application process. Your security is our priority.',
    ),
    OnboardingItem(
      imagePath: 'assets/image/onboarding2.jpg',
      title: 'Smart AI Assistance',
      description:
          'Our AI helps you through every step, making loan applications simple and personalised.',
    ),
    OnboardingItem(
      imagePath: 'assets/image/onboarding3.jpg',
      title: 'Track Your Progress',
      description:
          'Stay updated with real-time tracking and notifications throughout your loan journey.',
    ),
  ];

  bool get isLastPage => currentIndex.value == pages.length - 1;

  void onPageChanged(int index) => currentIndex.value = index;

  Future<void> next() async {
    if (isLastPage) {
      await completeOnboarding();
      return;
    }

    await pageController.animateToPage(
      currentIndex.value + 1,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> previous() async {
    if (currentIndex.value <= 0) return;

    await pageController.animateToPage(
      currentIndex.value - 1,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> completeOnboarding() async {
    Get.offAllNamed(AppRoutes.welcome);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
