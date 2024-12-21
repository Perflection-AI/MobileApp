import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/landing-bgp.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add some padding for layout
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Column(
                children: [
                  // Log in with email button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Log in with email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC7EEBB), // Swingie Green 100
                      foregroundColor: Colors.green[900],
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 1,
                      shadowColor: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  SizedBox(height: 12), // Spacing
                  // Sign up with email button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text('Sign up with email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.white),
                      ),
                      elevation: 1,
                      shadowColor: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  SizedBox(height: 16), // Spacing
                  // Divider with "OR"
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.8),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.8),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Continue with Apple button
                  TextButton.icon(
                    onPressed: () {
                      // Handle Apple login
                    },
                    icon: Icon(Icons.apple, color: Colors.white),
                    label: Text(
                      'Continue with Apple',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Continue with Google button
                  TextButton.icon(
                    onPressed: () {
                      // Handle Google login
                    },
                    icon: Image.asset(
                      'assets/mail_icon.png',
                      height: 20,
                      width: 20,
                    ),
                    label: Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Development helper button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/onboarding'); // Navigate to Onboarding
                },
                child: Text('Go to Onboarding Page'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
