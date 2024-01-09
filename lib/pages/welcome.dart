import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF06543),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shu Shie",
                  style: GoogleFonts.comfortaa(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/welcome.svg",
                      height: 300,
                    ),
                    const Gap(16),
                    Text(
                      "The best sushi in town",
                      style: GoogleFonts.comfortaa(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      "Feel the taste of the most popular Japanese food from anywhere and anytime",
                      style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          "Get Started",
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
