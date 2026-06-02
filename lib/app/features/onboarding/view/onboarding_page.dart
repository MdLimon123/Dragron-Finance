import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/features/onboarding/controller/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<OnboardingController>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final item in OnboardingController.pages) {
      precacheImage(AssetImage(item.imagePath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth < 380
                  ? 20.0
                  : 31.0;
              final contentWidth =
                  constraints.maxWidth - (horizontalPadding * 2);
              final preferredImageHeight = contentWidth * 0.82;
              const verticalPadding = 46.0;
              const fixedContentHeight = 145.0;
              const slideTextHeight = 128.0;
              final availableSlideHeight =
                  constraints.maxHeight - verticalPadding - fixedContentHeight;
              final maxImageHeight = availableSlideHeight - slideTextHeight;
              final imageHeight = maxImageHeight < 160.0
                  ? 160.0
                  : preferredImageHeight > maxImageHeight
                  ? maxImageHeight
                  : preferredImageHeight;
              final slideHeight = imageHeight + slideTextHeight;

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  22,
                  horizontalPadding,
                  24,
                ),
                child: Column(
                  children: [
                    _OnboardingHeader(controller: controller),
                    const SizedBox(height: 54),
                    SizedBox(
                      height: slideHeight,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: OnboardingController.pages.length,
                        itemBuilder: (context, index) {
                          return _OnboardingSlide(
                            item: OnboardingController.pages[index],
                            imageHeight: imageHeight,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => _PageIndicator(
                        currentIndex: controller.currentIndex.value,
                        itemCount: OnboardingController.pages.length,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => _GradientActionButton(
                        label: controller.isLastPage ? 'Get Started' : 'Next',
                        onPressed: controller.next,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader({required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BackButton(onPressed: controller.previous),
        const Spacer(),
        TextButton(
          onPressed: controller.completeOnboarding,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 47,
      decoration: BoxDecoration(
        color: AppColors.appBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1.2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: const SizedBox(
          width: 24,
          height: 24,
          child: Icon(
            Icons.chevron_left,
            size: 16,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.item, required this.imageHeight});

  final OnboardingItem item;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            item.imagePath,
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.currentIndex, required this.itemCount});

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          width: isActive ? 20 : 6,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF7F2828)
                : AppColors.textSecondary.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFA41F13), Color(0xFF292F36)],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, size: 20, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
