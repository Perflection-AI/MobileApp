import 'package:flutter/material.dart';
import 'landing_page.dart'; // Import the landing page for navigation

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Landing Page on any tap
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/landing-bgp.png'), // Correct asset path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
        ),
      ),
    );
  }
}
