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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(_destinations[index].image),
                    Text(_destinations[index].title, style: OnboardingTextStyles.large),
                    SizedBox(height: 10.0),
                    Text(_destinations[index].subtitle, style: OnboardingTextStyles.small,
                      textAlign: TextAlign.center),
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
                TextButton(onPressed: (){print('TAPPED');},
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
                    child: TextButton(onPressed: (){},
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
                      spacing: 4.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_destinations.length, (index) {
                        final isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8.0,
                          width: isActive ? 20.0 : 8.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: isActive ? Color(0xFF17223B) : Color(0xFF17223B).withAlpha((255 * 0.2).round()),
                          ),
                        );
                      }),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        padding: EdgeInsetsGeometry.only(right: 16.0),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Next', style: OnboardingTextStyles.mediumRed)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
