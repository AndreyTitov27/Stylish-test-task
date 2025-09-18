import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish_test_task/styles.dart';

class OnboardingDestination {
  final String title;
  final String subtitle;
  final String image;
  const OnboardingDestination({required this.title, required this.subtitle, required this.image});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingDestination> _destinations = [
    const OnboardingDestination(
      title: 'Choose Products',
      subtitle: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. '
        'Velit officia consequat duis enim velit mollit.',
      image: 'assets/images/onboarding1.svg',
    ),
    const OnboardingDestination(
      title: 'Make Payment',
      subtitle: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. '
        'Velit officia consequat duis enim velit mollit.',
      image: 'assets/images/onboarding2.svg',
    ),
    const OnboardingDestination(
      title: 'Get Your Order',
      subtitle: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. '
        'Velit officia consequat duis enim velit mollit.',
      image: 'assets/images/onboarding3.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _destinations.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Align(
                      alignment: Alignment(0.0, -0.3),
                      child: SvgPicture.asset(_destinations[index].image),
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.3),
                      child: Column(
                        spacing: 10.0,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_destinations[index].title, style: OnboardingTextStyles.large),
                          Text(_destinations[index].subtitle, style: OnboardingTextStyles.small,
                            textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: 16.0, top: MediaQuery.of(context).padding.top + 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${_currentPage + 1}', style: OnboardingTextStyles.medium),
                    Text('/3', style: OnboardingTextStyles.mediumGray),
                  ]
                ),
                TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/signUp'),
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.only(right: 16.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Skip', style: OnboardingTextStyles.medium)),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: EdgeInsetsGeometry.only(bottom: MediaQuery.of(context).padding.bottom),
                child: Stack(
                children: [
                  Align(
                    alignment: AlignmentGeometry.bottomLeft,
                    child: TextButton(onPressed: _onPrevTap,
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                      padding: EdgeInsets.only(left: 16.0),
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                      child: Text('Prev', style: OnboardingTextStyles.mediumGray)),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Row(
                      spacing: 8.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_destinations.length, (index) {
                        final isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isActive ? 8.0 : 10.0,
                          width: isActive ? 40.0 : 10.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999.0),
                            color: isActive ? Color(0xFF17223B) : Color(0xFF17223B).withAlpha((255 * 0.2).round()),
                          ),
                        );
                      }),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: TextButton(
                      onPressed: _onNextTap,
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        padding: EdgeInsetsGeometry.only(right: 16.0),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(_currentPage == 2 ? 'Get Started' : 'Next', style: OnboardingTextStyles.mediumRed),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _onNextTap() {
    setState(() {
      if (_currentPage < 2) {
        _pageController.animateToPage(
          ++_currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      else {
        Navigator.pushReplacementNamed(context, '/signUp');
      }
    });
  }
  void _onPrevTap() {
    setState(() {
      if (_currentPage > 0) {
        _pageController.animateToPage(
          --_currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
