import 'package:ecotech/components/button.dart';
import 'package:ecotech/helper/colors.dart';
import 'package:ecotech/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class VerdictScreen extends StatefulWidget {
  const VerdictScreen({Key? key, required this.verdict}) : super(key: key);

  final bool verdict;

  @override
  State<VerdictScreen> createState() => _VerdictScreenState();
}

class _VerdictScreenState extends State<VerdictScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.verdict == true
                    ? const Icon(
                        Icons.check_circle,
                        size: 200,
                        color: AppColors.brandColor,
                      )
                    : const Icon(
                        CupertinoIcons.clear_circled_solid,
                        size: 200,
                        color: Colors.red,
                      ),
                widget.verdict == true
                    ? Text(
                        "Your report has been successfully submitted!",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "Your report was classified as not e-waste!",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  text: "Back to Home",
                  hasIcon: false,
                  icon: const Icon(Icons.abc_outlined),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
