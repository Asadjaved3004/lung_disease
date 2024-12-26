import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lungs_disease/scan.dart';
import 'package:image_picker/image_picker.dart';

class AfterLoginScreen extends StatefulWidget {
  const AfterLoginScreen({super.key});

  @override
  _AfterLoginScreenState createState() => _AfterLoginScreenState();
}

class _AfterLoginScreenState extends State<AfterLoginScreen> {
  final List<String> categories = [
    "Normal",
    "TB",
    "Covid-19",
    "Viral Pneumonia",
    "Bacterial Pneumonia",
  ];

  final List<String> categoryImages = [
    "assets/images/lungs.png",
    "assets/images/tb.png",
    "assets/images/crona.png",
    "assets/images/bacteria.png",
    "assets/images/infection.png",
  ];

  final List<String> categoryDescriptions = [
    "• Healthy lungs with no visible signs of disease or infection.\n"
        "• Proper oxygen and carbon dioxide exchange.\n"
        "• Free of any abnormalities such as inflammation or lesions.",

    "• Caused by the bacterium Mycobacterium tuberculosis.\n"
        "• Primarily affects the lungs but can spread to other parts of the body.\n"
        "• Symptoms include:\n"
        "  - Persistent cough lasting more than 3 weeks.\n"
        "  - Weight loss and fatigue.\n"
        "  - Night sweats and fever.\n"
        "  - Blood in sputum.",

    "• A viral infection caused by the SARS-CoV-2 virus.\n"
        "• Primarily affects the respiratory system but may have systemic effects.\n"
        "• Symptoms include:\n"
        "  - Fever, dry cough, and fatigue.\n"
        "  - Difficulty breathing in severe cases.\n"
        "  - Loss of taste or smell.\n"
        "• Potential complications: pneumonia, ARDS (acute respiratory distress syndrome).",

    "• An infection of the lungs caused by viruses (e.g., influenza, RSV, coronaviruses).\n"
        "• Inflammation of the alveoli, often leading to fluid accumulation.\n"
        "• Symptoms include:\n"
        "  - Cough with or without mucus.\n"
        "  - Fever and chills.\n"
        "  - Difficulty breathing or shortness of breath.\n"
        "  - Chest pain during deep breaths or coughing.",

    "• A lung infection caused by bacteria, commonly Streptococcus pneumoniae.\n"
        "• Can affect one or both lungs.\n"
        "• Symptoms include:\n"
        "  - High fever and chills.\n"
        "  - Cough producing yellow, green, or bloody mucus.\n"
        "  - Shortness of breath and rapid breathing.\n"
        "  - Chest pain during coughing or breathing.\n"
        "  - Fatigue and muscle aches.",
  ];


  int _currentCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _startCategoryAnimation();
  }

  void _startCategoryAnimation() {
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 2), (timer) {
        setState(() {
          _currentCategoryIndex =
              (_currentCategoryIndex + 1) % categories.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    // Dynamically calculate the box size based on screen width and height
    double boxSize = screenHeight > 600 ? 80 : 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text("WELCOME"),
        backgroundColor: Color.fromRGBO(111, 159, 179, 1.0),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white10,
              ),
            ),
            Column(
              children: [
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
                const Center(
                  child: Text(
                    "Automatic Lungs Disease Detection",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.07), // 7% of screen height
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20, // Horizontal spacing
                  runSpacing: 20, // Vertical spacing
                  children: List.generate(categories.length, (index) {
                    return _buildCategoryShape(
                      categories[index],
                      categoryImages[index],
                      categoryDescriptions[index],
                      boxSize,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.05), // Adjusted spacing
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageRecognitionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Color.fromRGBO(111, 159, 179, 1.0),
                  ),
                  child: const Text(
                    "Scan Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add View History functionality
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Color.fromRGBO(111, 159, 179, 1.0),
                  ),
                  child: const Text(
                    "View History",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20), // Extra bottom padding for safety
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryShape(String categoryName, String imagePath,
      String description, double boxSize) {
    return GestureDetector(
      onTap: () {
        _showCategoryDescription(context, categoryName, description);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: boxSize,
            height: boxSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: boxSize,
                height: boxSize,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryDescription(BuildContext context, String categoryName,
      String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(categoryName),
          content: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}