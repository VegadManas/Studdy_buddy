import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studdy_buddy/home_screen/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Set onboarding seen
  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Widget> onBoardingPages = [
      OnBoardingCard(
        image: "assets/onboarding/on1.jpg",
        title: "Welcome",
        description: "Discover our app and its amazing features.",
        buttonText: "Next",
        buttonColor: colorScheme.primary,
        textColor: colorScheme.onPrimary,
        onPressed: () {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
      OnBoardingCard(
        image: "assets/onboarding/on2.jpg",
        title: "Features",
        description:
            "Manage timetable, deadlines, GPA & study materials easily.",
        buttonText: "Next",
        buttonColor: colorScheme.primary,
        textColor: colorScheme.onPrimary,
        onPressed: () {
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
      OnBoardingCard(
        image: "assets/onboarding/on3.jpg",
        title: "Get Started",
        description: "Ready to explore? Let's go!",
        buttonText: "Get Started",
        buttonColor: colorScheme.primary,
        textColor: colorScheme.onPrimary,
        onPressed: () async {
          await _completeOnboarding();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: onBoardingPages,
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: _pageController,
              count: onBoardingPages.length,
              effect: WormEffect(
                activeDotColor: colorScheme.primary,
                dotColor: colorScheme.primary.withOpacity(0.3),
                dotHeight: 12,
                dotWidth: 12,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const OnBoardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(child: Image.asset(image, fit: BoxFit.cover)),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(buttonText, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
