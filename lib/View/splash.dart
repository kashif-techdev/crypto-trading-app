import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Full-Screen Background Image/GIF
            Positioned.fill(
              child: Image.asset(
                'assets/image/1.gif',
                fit: BoxFit.cover, // Adjust as needed (BoxFit.cover, BoxFit.contain, etc.)
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Content (Text & Button)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.1),
              child: Column(
                children: [
                  const Spacer(), // Push content to the bottom
                  // Title
                  Text(
                    'The Future',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isPortrait ? 40 : 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Subtitle
                  Text(
                    "Learn more about cryptocurrency, let's dive into the future of crypto",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isPortrait ? 18 : 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF7B4397),
                            const Color(0xFF0A84FF),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.05,
                          vertical: isPortrait ? myHeight * 0.015 : myHeight * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Let's Start",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(310 / 360),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Add space below the button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
