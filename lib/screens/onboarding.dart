import 'package:ecotech/components/button.dart';
import 'package:ecotech/helper/colors.dart';
import 'package:ecotech/models/onboarding.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import "package:shared_preferences/shared_preferences.dart";

import 'login_register.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentindex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingContent.length,
              onPageChanged: (int index) {
                setState(() {
                  currentindex = index;
                });
              },
              itemBuilder: (context, i) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Image.asset(
                          onboardingContent[i].image,
                          height: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Text(
                            onboardingContent[i].description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingContent.length,
              (index) => buildDots(index, context),
            ),
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.all(40),
            child: PrimaryButton(
              text: currentindex == onboardingContent.length - 1 ? 'Continue' : 'Next',
              hasIcon: false,
              icon: const Icon(Icons.pin),
              onPressed: () async {
                if (currentindex == onboardingContent.length - 1) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('firstTime', false);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginRegister(),
                      transitionDuration: const Duration(milliseconds: 1000),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                        return SlideTransition(
                          position:
                              Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
                                  .animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                } else {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentindex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.brandColor,
      ),
    );
  }
}
