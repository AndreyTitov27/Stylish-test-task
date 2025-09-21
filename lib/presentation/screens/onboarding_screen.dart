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

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _nextButtonText = 'Next';
  late final AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
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
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutExpo),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _destinations.length,
            onPageChanged: (index) => setState(() {
              if (index > _currentPage) {
                if (index == 2) animateNextButton();
              } else if (index < _currentPage) {
                if (index == 1) animateNextButton();
              }
              _currentPage = index;
            }),
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
          Align(
            alignment: AlignmentGeometry.topLeft,
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 16.0,
                top: MediaQuery.of(context).padding.top + 24.0,
              ),
              child: Row(
                children: [
                  Text('${_currentPage + 1}', style: OnboardingTextStyles.medium),
                  Text('/3', style: OnboardingTextStyles.mediumGray),
                ]
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.topRight,
            child: TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/signUp'),
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).padding.top + 24.0,
                  horizontal : 16.0,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Skip', style: OnboardingTextStyles.medium)),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: AnimatedSlide(
                    offset: _currentPage == 0
                      ? Offset(-1.5, 0.0)
                      : Offset(0.0, 0.0),
                    curve: _currentPage == 0 ? Curves.easeInExpo : Curves.easeOutExpo,
                    duration: Duration(milliseconds: 300),
                    child: TextButton(
                      onPressed: _onPrevTap,
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).padding.bottom != 0.0
                            ? MediaQuery.of(context).padding.bottom
                            : 16.0,
                          horizontal: 16.0,
                        ),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Prev',
                        style: OnboardingTextStyles.mediumGray,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(
                      bottom: MediaQuery.of(context).padding.bottom != 0.0
                        ? MediaQuery.of(context).padding.bottom
                        : 16.0,
                    ),
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
                            color: isActive
                              ? Color(0xFF17223B)
                              : Color(0xFF17223B).withAlpha((255 * 0.2).round()),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: SlideTransition(
                    position: _offsetAnimation,
                    child: TextButton(
                      onPressed: _onNextTap,
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: MediaQuery.of(context).padding.bottom != 0.0
                            ? MediaQuery.of(context).padding.bottom
                            : 16.0,
                          horizontal: 16.0,
                        ),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        _nextButtonText,
                        style: OnboardingTextStyles.mediumRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _onNextTap() {
    setState(() {
      if (_currentPage < 2) {
        if (_currentPage == 1) {
          animateNextButton();
        }
        _pageController.animateToPage(
          ++_currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pushReplacementNamed(context, '/signUp');
      }
    });
  }
  void _onPrevTap() {
    setState(() {
      if (_currentPage > 0) {
        if (_currentPage == 2) {
          animateNextButton();
        }
        _pageController.animateToPage(
          --_currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  Future<void> animateNextButton() async {
    await _controller.forward();
    setState(() {
      if (_currentPage == 2) {
        _nextButtonText = 'Get Started';
      } else if (_currentPage == 1) {
        _nextButtonText = 'Next';
      }
    });
    await _controller.reverse();
  }
}
