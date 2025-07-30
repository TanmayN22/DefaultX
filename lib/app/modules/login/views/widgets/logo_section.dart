import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo container
          SizedBox(
            width: 500,
            height: 500,
            child: Center(
              child: Image.asset(
                'assets/defaultx_logo.png',
                width: 1000,
                height: 1000,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if logo doesn't load
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(25, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(51, 255, 255, 255),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.account_circle,
                      size: 120,
                      color: Color.fromARGB(204, 255, 255, 255),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
