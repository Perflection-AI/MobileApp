import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentStep = 0;

  final List<Map<String, dynamic>> onboardingSteps = [
    {
      'title': 'Please answer this questionnaire to receive an accurate Analysis 🎉',
      'description':
          'There are 6 questions that help us to customize the best plan for you. Filling the questions with accurate personal information will improve the accuracy of the plan schedule.',
      'image': 'assets/questionnaire_intro.png',
      'showInput': false,
    },
    {
      'title': 'What is your name? 🤔',
      'description': 'You can always change it from Profile > Setting',
      'fields': [
        {'hint': 'First name'},
        {'hint': 'Last name'}
      ],
      'showInput': true,
    },
    {
      'title': 'Which gender best describes you? 🤔',
      'description': 'Gender helps us scale your 3D model.',
      'options': ['Male', 'Female'],
      'showInput': false,
    },
    {
      'title': "What's your age? 🤔",
      'description': 'This will help us personalize your app experience.',
      'defaultValue': 25,
      'type': 'age_picker',
    },
    {
      'title': "What's your height? 🤔",
      'description': 'Height affects how we generate your 3D swing model.',
      'unitOptions': ['Inch', 'cm'],
      'defaultUnit': 'cm',
      'defaultValue': 150,
      'type': 'scroll_picker',
    },
    {
      'title': "What's your weight? 🤔",
      'description': 'Weight affects your swing analysis.',
      'unitOptions': ['lbs', 'kg'],
      'defaultUnit': 'kg',
      'defaultValue': 60,
      'type': 'scroll_picker',
    },
    {
      'title': 'Do you play golf left or right handed? 🙌',
      'description': 'Dexterity is used for auto swing capture guidance.',
      'options': ['Left-handed', 'Right-handed'],
      'showInput': false,
    },
    {
      'title': 'What is your proficiency on playing golf? ⛳',
      'description': 'This will help us personalize your coaching experience.',
      'options': [
        '1 - Fundamental Awareness',
        '2 - Novice',
        '3 - Intermediate',
        '4 - Advanced',
        '5 - Expert'
      ],
      'showInput': false,
    },
  ];

  String selectedUnit = ''; // Current selected unit for height/weight
  int selectedValue = 0; // Current selected value for picker

  @override
  void initState() {
    super.initState();
    if (onboardingSteps[currentStep]['type'] == 'scroll_picker' ||
        onboardingSteps[currentStep]['type'] == 'age_picker') {
      selectedValue = onboardingSteps[currentStep]['defaultValue'];
      selectedUnit = onboardingSteps[currentStep]['defaultUnit'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = onboardingSteps[currentStep];

    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: currentStep > 0
              ? () {
                  setState(() {
                    currentStep--;
                  });
                }
              : null,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Navigation Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingSteps.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentStep
                      ? Color(0xFF41902D) // Current step (Swingie Green)
                      : index < currentStep
                          ? Color(0xFF41902D).withOpacity(0.4) // Past steps
                          : Color(0xFFE5E7EB), // Future steps (Grey)
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    step['description'],
                    style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // Render image Fields
                  if (currentStep == 0 && step['image'] != null)
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            step['image'], // Ensure the correct path is used
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  // Render Input Fields
                  if (step['showInput'] == true &&
                      step['fields'] != null &&
                      step['fields'].isNotEmpty)
                    ...step['fields']
                        .map<Widget>(
                          (field) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: field['hint'],
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  // Render Options (e.g., Gender, Left/Right-handed, Proficiency Levels)
                  if (step['options'] != null && step['options'].isNotEmpty)
                    ...step['options'].map<Widget>((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle selection logic here if needed
                          },
                          child: Text(option,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide(color: Color(0xFFD1D5DB)), // Gray-300 border
                            ),
                            elevation: 1,
                            shadowColor: Colors.black.withOpacity(0.05), // Shadow effect
                          ),
                        ),
                      );
                    }).toList(),

                 // Render Age Picker
                  if (step['type'] == 'age_picker')
                    Expanded(
                      child: Container(
                        height: 300, // Increase height to match scroll_picker
                        child: ScrollConfiguration(
                          behavior: NoGlowScrollBehavior(), // Remove scroll glow
                          child: Stack(
                            children: [
                              ListWheelScrollView.useDelegate(
                                itemExtent: 60, // Increase item size for better visibility
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    selectedValue = value + 18; // Age range starts at 18
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    int displayedValue = index + 18; // Display ages 18–100
                                    return Center(
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: displayedValue == selectedValue
                                              ? Colors.grey[300]
                                              : Colors.transparent, // Highlight selected
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          displayedValue.toString(),
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: displayedValue == selectedValue
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 83, // 83 options (18–100 inclusive)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Render Height/Weight Picker
                  if (step['type'] == 'scroll_picker') ...[
                    Container(
                      width: 328, // Fixed width for the picker
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF3F4F6), // Gray 100 background
                      ),
                      child: Row(
                        children: step['unitOptions'].map<Widget>((unit) {
                          final isSelected = selectedUnit == unit;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedUnit = unit;
                                  selectedValue = unit == 'cm'
                                      ? 150
                                      : unit == 'inch'
                                          ? 60
                                          : unit == 'kg'
                                              ? 60
                                              : 120; // Default values for each unit
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFF41902D) : Colors.transparent,
                                  borderRadius: unit == step['unitOptions'][0]
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        )
                                      : BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  unit,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        height: 300,
                        child: ScrollConfiguration(
                          behavior: NoGlowScrollBehavior(), // Removes glow
                          child: Stack(
                            children: [
                              ListWheelScrollView.useDelegate(
                                itemExtent: 60,
                                physics: FixedExtentScrollPhysics(),
                                controller: FixedExtentScrollController(
                                  initialItem: selectedUnit == 'cm'
                                      ? 150 - 150 // Default for cm starts at 150
                                      : selectedUnit == 'inch'
                                          ? 60 - 60 // Default for inch starts at 60
                                          : selectedUnit == 'kg'
                                              ? 60 - 60 // Default for kg starts at 60
                                              : 120 - 120, // Adjust other cases if needed
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    selectedValue = value +
                                        (selectedUnit == 'cm'
                                            ? 150
                                            : (selectedUnit == 'kg' ? 60 : 60));
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    int displayedValue = index +
                                        (selectedUnit == 'cm'
                                            ? 150
                                            : (selectedUnit == 'kg' ? 60 : 60));
                                    return Center(
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: displayedValue == selectedValue
                                              ? Colors.grey[300]
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          displayedValue.toString(),
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: displayedValue == selectedValue
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: (selectedUnit == 'kg' || selectedUnit == 'inch')
                                      ? 200
                                      : 300, // Adjust limits here
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    selectedUnit, // Display the unit dynamically
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "You can always change it from Profile > Setting",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        height: 1.33, // Line-height equivalent
                        color: Color(0x4C424242), // rgba(66, 66, 66, 0.75)
                      ),
                    ),
                  ),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (currentStep < onboardingSteps.length - 1) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        // Finish or navigate to the next page
                      }
                    },
                    child: Text(
                        currentStep == onboardingSteps.length - 1
                            ? 'Finish'
                            : 'Continue'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF41902D), // Swingie Green
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Skip logic here
                    },
                    child: Text(
                      'Skip for now',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
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
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Disable the glow effect
  }
}
