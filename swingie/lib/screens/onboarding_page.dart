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
                  // Render Gender Options
                  if (step['options'] != null && step['options'].isNotEmpty)
                    ...step['options']
                        .map<Widget>(
                          (option) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(option),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  // Render Age Picker
                  if (step['type'] == 'age_picker')
                    Container(
                      height: 150,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedValue = value + 18; // Age range starts at 18
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                '${index + 18}', // Display ages 18–100
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          childCount: 83, // 83 options (18–100 inclusive)
                        ),
                      ),
                    ),
                  // Render Height/Weight Picker
                  if (step['type'] == 'scroll_picker') ...[
                    ToggleButtons(
                      isSelected: [
                        selectedUnit == step['unitOptions'][0],
                        selectedUnit == step['unitOptions'][1],
                      ],
                      onPressed: (index) {
                        setState(() {
                          selectedUnit = step['unitOptions'][index];
                          selectedValue =
                              selectedUnit == 'cm' ? 150 : (selectedUnit == 'kg' ? 60 : 60);
                        });
                      },
                      children: step['unitOptions']
                          .map<Widget>(
                            (unit) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                unit,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 150,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        physics: FixedExtentScrollPhysics(),
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
                              child: Text(
                                displayedValue.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          childCount: 100, // Display 100 options
                        ),
                      ),
                    ),
                  ],
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
