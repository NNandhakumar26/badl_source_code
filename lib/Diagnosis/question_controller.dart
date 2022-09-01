import 'package:badl_app/diagnosis/suggestion_widget.dart';
import 'package:badl_app/modals/condition.dart';
import 'package:badl_app/modals/heading.dart';
import 'package:badl_app/modals/patientInfo.dart';
import 'package:badl_app/modals/preference.dart';
import 'package:badl_app/modals/question_set.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  var on_own_hand = true;
  late bool lessThan5;
  late bool hasOrthoProsthesis;
  String? gender;
  String? selectOrthoses;

  //NEW SET

  late Map<String, dynamic> userInput;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PatientDetails patientDetails = PatientDetails(
    userID: 'userID',
    age: 0,
    gender: 'Male',
  );

  int questionIndex = 0;
  int preferenceIndex = 0;
  Map questions = {};

  @override
  void onInit() {
    super.onInit();
    resetData();
    userInput = <String, dynamic>{};
  }

  Map originalQuestion = <String, QuestionSet>{
    "Eating": QuestionSet(
      heading: Heading(
        question: 'Eating',
        scoring: Scoring(
          total: 0.20,
        ),
      ),
      preferences: [
        Preference(
          question: 'How do you prefer to eat regularly?',
          components: [
            Component(id: 1, value: 'On Own Hand'),
            Component(id: 2, value: 'Using Spoon/Fork'),
          ],
          subComponents: [
            SubComponent(
              // minAge: 5,
              // maxAge: 10,
              // isMale: true,
              ids: [1, 2],
              value: 'Able to access and use plate appropriately',
            ),
            SubComponent(
                // minAge: 11,
                // maxAge: 15,
                // isMale: false,

                ids: [2],
                value: 'Able to access and use spoon/fork appropriately'),
            SubComponent(ids: [
              1
            ], value: 'Take the appropriate quantity of food without spillage'),
            SubComponent(
                minAge: 5,
                maxAge: 10,
                ids: [2],
                value:
                    'Take the appropriate quantity of food using a spoon without spillage'),
            SubComponent(ids: [1], value: 'Able to eat on own'),
            SubComponent(ids: [2], value: 'Able to eat using spoon/fork'),
            SubComponent(
                ids: [1, 2],
                value:
                    'Can break into pieces (chapati ,dosa, or tiffin items) '),
            SubComponent(ids: [1, 2], value: 'Mix rice with curry'),
            SubComponent(ids: [1, 2], value: 'Ability to chew'),
            SubComponent(ids: [1, 2], value: 'Able to drink water'),
            SubComponent(ids: [1, 2], value: 'Wash the hands'),
            SubComponent(ids: [1, 2], value: 'Wipe hands with towel'),
          ],
        ),
      ],
    ),
    "Bathing": QuestionSet(
      heading: Heading(
        question: 'Bathing',
        scoring: Scoring(
          total: 0.15,
        ),
      ),
      preferences: [
        Preference(
          question: 'How do you prefer to take a bath regularly',
          components: [
            Component(
              id: 1,
              value:
                  'Open Space (motor pump sets, backyard, water resources such as lake)',
            ),
            Component(
              id: 2,
              value: 'Bathroom using bucket and mug',
            ),
            Component(
              id: 3,
              value: 'Shower',
            ),
            Component(
              id: 4,
              value: 'Tub',
            ),
          ],
          subComponents: [
            SubComponent(
                ids: [1, 2, 3, 4], value: 'Able to access the dress/towel'),
            SubComponent(
                ids: [2, 3, 4],
                value: 'hang the towel and clothes in the hanging bar'),
            SubComponent(
                ids: [2, 3, 4],
                value:
                    'adjust the tap with the temperature needed (hot or cold )'),
            SubComponent(
                ids: [2, 3, 4],
                value: 'Able to open and close the tap/ shower'),
            SubComponent(
                ids: [1, 2, 3, 4],
                value: 'Able to apply soap, shampoo and conditioner '),
            SubComponent(
                ids: [1, 2, 3, 4],
                value: 'Able to operate electrical appliances '),
            SubComponent(
                ids: [1, 2, 3, 4], value: 'Able to take shower and clean hair'),
            SubComponent(
                ids: [1, 2, 3, 4],
                value: 'apply soap completely throughout the bod'),
            SubComponent(
                ids: [1, 2, 3, 4],
                value: 'use bathing brush and clean the whole body'),
            SubComponent(
                ids: [1, 2, 3, 4],
                value: 'replace the soap , shampoo and conditioner'),
            SubComponent(
                ids: [1, 2, 3, 4], value: 'wipe your whole body with towel '),
            SubComponent(ids: [4], value: 'able to get into the tub'),
            SubComponent(ids: [1], value: 'able to get into pond'),
          ],
        )
      ],
    ),
    "Mobility": QuestionSet(
      heading: Heading(
        question: 'Mobility',
        scoring: Scoring(
          total: 0.15,
        ),
      ),
      preferences: [
        Preference(
          question: 'How do you prefer to take a bath regularly',
          subComponents: [
            SubComponent(
                ids: [1], value: 'Able to getup from lying to sitting'),
            SubComponent(
                ids: [1], value: 'Able to get back from sitting to lying'),
            SubComponent(
                ids: [1], value: 'Able to getup from sitting to standing'),
            SubComponent(
                ids: [1], value: 'Able to get back from standing to sitting'),
            SubComponent(
                ids: [1], value: 'Able to perform standing to walking'),
            SubComponent(ids: [1], value: 'Able to get back from walking'),
            SubComponent(ids: [1], value: 'Able to bend'),
            SubComponent(ids: [1], value: 'Reaching out for objects'),
          ],
        ),
      ],
    ),
    "Toileting": QuestionSet(
      heading: Heading(
        question: 'Toileting',
        scoring: Scoring(
          total: 0.15,
        ),
      ),
      preferences: [
        Preference(
          question: 'Bowel/Bladder Control',
          components: [
            Component(
              id: 1,
              value: 'Indian Commode',
            ),
            Component(
              id: 2,
              value: 'Western Commode',
            ),
          ],
          subComponents: [
            SubComponent(ids: [1, 2], value: 'Clean the Commode'),
            SubComponent(ids: [1], value: 'Sit properly on the commode Squat'),
            SubComponent(
                ids: [1, 2],
                value: 'Can clean himself using water gun / mug and water'),
            SubComponent(
                ids: [1],
                value:
                    'Able to flush/ pour water  and waits till the commode is clean'),
            SubComponent(ids: [1, 2], value: 'Wash the hands and legs'),
            SubComponent(ids: [1], value: 'Maintain squat posture till voids'),
            SubComponent(ids: [1], value: 'Ability to squat to stand'),
            SubComponent(
              ids: [2],
              value: 'Sit properly on the commode sitting',
            ),
            SubComponent(
              ids: [2],
              value: 'Able to flush and waits till the commode is clean',
            ),
            SubComponent(
              ids: [2],
              value: 'Maintain sitting posture till voids',
            ),
            SubComponent(
              ids: [2],
              value: 'Ability to sit to stand',
            ),
          ],
        ),
      ],
    ),
    "Personal Hygiene": QuestionSet(
      criteria: Criteria(
        parameter: 'Gender',
        valueIDs: {
          'male': [
            1,
            3,
            4,
          ],
          'female': [
            1,
            2,
            4,
          ],
        },
      ),
      heading: Heading(
        question: "Personal Hygiene",
        scoring: Scoring(
          total: 0.15,
        ),
      ),
      preferences: [
        Preference(
          id: 1,
          isSelected: false,
          question: 'How do you brush your teeth regularly?',
          components: [
            Component(
              id: 1,
              value: 'Brush and Paste',
            ),
            Component(
              id: 2,
              value: 'Brush and Powder',
            ),
            Component(
              id: 3,
              value: 'Neem Sticks',
            ),
            Component(
              id: 4,
              value: 'Neemsticks with powder',
            ),
            Component(
              id: 5,
              value: 'Hand with powder',
            ),
            Component(
              id: 6,
              value: 'Mouth Wash',
            ),
          ],
          subComponents: [
            SubComponent(
              ids: [1, 2],
              value: "Hold the Brush properly",
            ),
            SubComponent(
              ids: [3, 4],
              value: 'Hold the Neem Sticks Properly',
            ),
            SubComponent(
              ids: [1],
              value: 'Hold the paste properly',
            ),
            SubComponent(
              ids: [1, 2],
              value: 'Wash the Bristles',
            ),
            SubComponent(
              ids: [3, 4],
              value: 'Able to bite the neem sticks',
            ),
            SubComponent(
              ids: [1],
              value: 'Open and close the cap of the paste',
            ),
            SubComponent(
              ids: [6],
              value: 'Open and close the cap of mouthwash',
            ),
            SubComponent(
              ids: [2, 4, 5],
              value: 'Able to open and close the container of the tooth powder',
            ),
            SubComponent(
              ids: [2, 4, 5],
              value: 'Able to open and close the container of the tooth powder',
            ),
            SubComponent(
              ids: [2, 4],
              value: 'Able to hold the powder till brushing',
            ),
            SubComponent(
              ids: [1],
              value: 'Apply the paste properly with appropriate pressure',
            ),
            SubComponent(
              ids: [1, 2, 3, 4, 5, 6],
              value:
                  'Able to brush for appropriate period in appropriate manner ',
            ),
            SubComponent(
              ids: [1, 2, 3, 4, 5, 6],
              value: 'Splitting',
            ),
            SubComponent(
              ids: [1, 2, 3, 4, 5, 6],
              value: 'Gargle the mouth with water and spitting',
            ),
            SubComponent(
              ids: [1, 2, 3, 4, 5, 6],
              value: 'Clean outside of the mouth',
            ),
            SubComponent(
              ids: [1, 2],
              value: 'Clean the brush',
            ),
          ],
        ),
        Preference(
          id: 2,
          isSelected: false,
          question: 'Menstruation',
          subComponents: [
            SubComponent(
                ids: [1],
                value: 'Use of clean sanitary napkins and undergarments'),
            SubComponent(
                ids: [1], value: 'Able to wash/ clean body using soaps'),
            SubComponent(
                ids: [1],
                value: 'Regularly or timely changing of sanitary napkins'),
            SubComponent(
                ids: [1],
                value:
                    'Proper Positioning of sanitary napkins in undergarments'),
            SubComponent(ids: [1], value: 'Usage of menstrual cups or tampons'),
          ],
        ),
        Preference(
          id: 3,
          isSelected: false,
          question:
              'Trimming/Shaving:  (Applicable only for the individuals who trim on their own)',
          subComponents: [
            SubComponent(
                ids: [1], value: 'Able to handle the trimmers/razors properly'),
            SubComponent(ids: [1], value: 'Able to use the mirror properly'),
            SubComponent(
                ids: [1],
                value: 'Able to use shaving cream and after shave lotion'),
            SubComponent(
                ids: [1],
                value:
                    'Open and close the cap  of shaving cream / after shave lotion'),
            SubComponent(ids: [1], value: 'Clean the razor/ trimmer'),
          ],
        ),
        Preference(
          id: 4,
          isSelected: false,
          question: 'Combing',
          subComponents: [
            SubComponent(
                ids: [1], value: 'Able to go to dressing table or mirror'),
            SubComponent(ids: [1], value: 'Take the comb and hold it properly'),
            SubComponent(ids: [1], value: 'Able to see mirror properly'),
            SubComponent(ids: [1], value: 'Able to comb properly'),
            SubComponent(ids: [1], value: 'Replace the comb back'),
            SubComponent(ids: [1], value: 'Applying oil or hair styling cream'),
            SubComponent(
                ids: [1],
                value: 'Appropriate use of  oil/ hair cream containers'),
          ],
        ),
      ],
    ),
    "Dressing": QuestionSet(
      heading: Heading(
        question: 'Dressing',
        scoring: Scoring(
          total: 0.20,
        ),
      ),
      criteria: Criteria(
        parameter: 'Gender',
        valueIDs: {
          'male': [
            1,
            2,
            4,
            5,
          ],
          'female': [
            1,
            2,
            3,
            5,
          ],
        },
      ),
      preferences: [
        Preference(
          id: 1,
          isSelected: false,
          question: 'Upper Body Dressing',
          subComponents: [
            SubComponent(ids: [1], value: 'Access to the dress'),
            SubComponent(ids: [1], value: 'Able to roll the dress'),
            SubComponent(ids: [1], value: 'Able to wear through the neck'),
            SubComponent(ids: [1], value: 'Able to wear sleeves through hands'),
            SubComponent(ids: [1], value: 'Pull the dress downward'),
            SubComponent(ids: [1], value: 'Adjust the dress'),
            SubComponent(ids: [1], value: 'Remove the fasteners'),
            SubComponent(
                ids: [1], value: 'Pull the dress upward through the head'),
            SubComponent(ids: [1], value: 'Doffing the sleeves'),
            SubComponent(
                ids: [1],
                value: 'Pull the hook stretch the strap towards the center'),
            SubComponent(
                ids: [1],
                value:
                    'Use pressure to put the hook ((applicable only for female/transfemale)'),
            SubComponent(
                ids: [1],
                value:
                    'Wearing on one sleeve and using the other hand get the dress at the back and wear the other sleeve'),
            SubComponent(ids: [1], value: 'Able to roll the sleeves up'),
            SubComponent(ids: [1], value: 'Able to tuck in properly'),
            SubComponent(ids: [1], value: 'Able to wear a tie'),
          ],
        ),
        Preference(
          id: 2,
          isSelected: false,
          question: 'Lower Body Dressing',
          subComponents: [
            SubComponent(ids: [1], value: 'Take the dress'),
            SubComponent(ids: [1], value: 'Remove the fasteners'),
            SubComponent(
                ids: [1],
                value: 'able to insert both the legs and pull upwards'),
            SubComponent(ids: [1], value: 'Pull the pants up wards'),
            SubComponent(ids: [1], value: 'Put the fasteners'),
            SubComponent(ids: [1], value: 'Adjust your dress'),
            SubComponent(ids: [1], value: 'Able to stretch to reach down'),
            SubComponent(ids: [1], value: 'Able to wear belt'),
            SubComponent(ids: [1], value: 'Pull the pants downwards'),
            SubComponent(ids: [1], value: 'Take off the legs from the pants '),
          ],
        ),
        Preference(
          id: 3,
          isSelected: false,
          question: 'Saree',
          subComponents: [
            SubComponent(ids: [1], value: 'Putting blouse and fixing hooks'),
            SubComponent(ids: [1], value: 'Putting petticoat'),
            SubComponent(ids: [1], value: 'Tying the petticoat'),
            SubComponent(
                ids: [1],
                value:
                    'Adjust the petticoat and figure out the bottom of saree'),
            SubComponent(ids: [1], value: 'Able to twist and tuck the saree'),
            SubComponent(
                ids: [1], value: 'Adjust the length or height of the saree'),
            SubComponent(
                ids: [1],
                value: 'Twin and twist the saree around the waist for 2 times'),
            SubComponent(
                ids: [1], value: 'Make pleats, adjust and arrange pleats'),
            SubComponent(
                ids: [1], value: 'Bring the pleats in front of the shoulder'),
            SubComponent(ids: [1], value: 'Pin the pleats using safety pins'),
            SubComponent(
                ids: [1],
                value:
                    'Grab the first pleats and twist around the trunk from right side to left side'),
            SubComponent(
                ids: [1],
                value:
                    'Make pleats with extra fabric and arrange pleats in order or proper position'),
          ],
        ),
        Preference(
          id: 4,
          isSelected: false,
          question: 'Dhoti',
          subComponents: [
            SubComponent(
                ids: [1], value: 'Able to hold the dhoti horizontally'),
            SubComponent(
                ids: [1],
                value: 'Able to divide the dhoti in two equal halves'),
            SubComponent(ids: [1], value: 'Able to bring around the waist'),
            SubComponent(ids: [1], value: 'Able to roll'),
            SubComponent(
                ids: [1],
                value:
                    'Able to fold on right and left side and tuck the folds in the waistband'),
            SubComponent(
                ids: [1],
                value:
                    'Able to take the folded material and pass it through between the legs'),
            SubComponent(ids: [
              1
            ], value: 'Able to snug in the folded material onto the waistband'),
          ],
        ),
        Preference(
          id: 5,
          isSelected: false,
          question: 'Footwear',
          subComponents: [
            SubComponent(
                ids: [1], value: ' Able to identify the proper Footwear'),
            SubComponent(
                ids: [1], value: ' Able to discriminate right and left side'),
            SubComponent(ids: [1], value: ' access and wear socks '),
            SubComponent(
                ids: [1],
                value: ' Able to identify the inside and outside of the socks'),
            SubComponent(ids: [1], value: ' Able to wear footwear'),
            SubComponent(ids: [1], value: ' Able to tie shoe lace'),
            SubComponent(ids: [1], value: ' Appropriate use of fasteners'),
          ],
        ),
      ],
    ),
  };

  void resetData() {
    patientDetails = PatientDetails(userID: 'userID', age: 0, gender: 'Male');
    lessThan5 = false;
    hasOrthoProsthesis = false;
    questionIndex = 0;
    preferenceIndex = 0;
    questions = originalQuestion;
  }

  QuestionSet get selectedQuestionSetValue => questionSetIndex(questionIndex);

  set setSubcomponent(List<SubComponent> subcomponents) {
    (questions.entries.elementAt(questionIndex).value)
        .preferences[preferenceIndex]
        .subComponents = subcomponents;
  }

  set preferences(List<Preference> preferences) {
    (questions.entries.elementAt(questionIndex).value).preferences =
        preferences;
  }

  QuestionSet get nextQuestion => (questionIndex < questions.entries.length)
      ? questionSetIndex(questionIndex + 1)
      : selectedQuestionSetValue;

  QuestionSet questionSetIndex(int index) =>
      questions.entries.elementAt(index).value;

  // ** Values Used for the UI **
  String get displayTitle => questions.entries.elementAt(questionIndex).key;
  String get displaySubTitle => displayPreference.question ?? '';

  String get displayQuestion =>
      selectedQuestionSetValue.heading!.question ?? '';

  Preference get displayPreference {
    return selectedQuestionSetValue.preferences[preferenceIndex];
    // try {
    //   return
    // } catch (e) {
    //   return (questions.entries
    //       .elementAt(questionIndex)
    //       .value
    //       .preferences[preferenceIndex - 1]);
    // }
  }

  List<Component> get displayComponents => displayPreference.components ?? [];

  Set<SubComponent> displaySubcomponents = {};

  void updateDisplaySubcomponents() {
    if (displayPreference.components == null) {
      print('Entered into the null component value function');
      displaySubcomponents = displayPreference.subComponents?.toSet() ?? {};
      return;
    }
    Set<int> selectedComponentIds = {};
    Set<SubComponent> returnValue = {};
    for (var component in displayComponents)
      if (component.isChecked) selectedComponentIds.add(component.id!);

    for (var componentId in selectedComponentIds) {
      for (var subcomponent in displayPreference.subComponents!) {
        if (subcomponent.ids!.contains(componentId))
          returnValue.add(subcomponent);
      }
    }

    displaySubcomponents = returnValue;
  }

  Future<bool> updateResponse() async {
    bool hasCriteria() =>
        (nextQuestion.criteria != null) &&
        (nextQuestion != selectedQuestionSetValue);

    try {
      if (questionIndex < questions.entries.length) {
        print('The selected question set value is $selectedQuestionSetValue');
        if (preferenceIndex + 1 !=
            selectedQuestionSetValue.preferences.length) {
          print('The continuation of preference index');
          setSubcomponent = displaySubcomponents.toList();
          preferenceIndex++;
          if (displayPreference.components == null)
            updateDisplaySubcomponents();
          update();
          return false;
        } else {
          print('The end of preference index');
          addUserResponse();

          if (hasCriteria())
            await preferencesSelectionWidget();
          else {
            print('The no criteria  part');
            questionIndex++;
            preferenceIndex = 0;
            displaySubcomponents = {};
            if (displayPreference.components == null)
              updateDisplaySubcomponents();
          }
          update();
          return false;
        }
      }
      update();
      return false;
    } catch (e) {
      return true;
    }
  }

  Future<dynamic> preferencesSelectionWidget() {
    print('The popup part');
    return showDialog<List<Preference>>(
      context: scaffoldKey.currentContext!,
      barrierDismissible: false,
      builder: (builder) => SuggestionWidget(
        title: nextQuestion.heading?.question ?? '',
        referenceQuestionIndex: questionIndex + 1,
      ),
    ).then(
      (preferenceList) {
        questionIndex++;
        preferenceIndex = 0;
        displaySubcomponents = {};
        selectedQuestionSetValue.preferences
            .removeWhere((element) => element.isSelected == false);
        if (displayPreference.components == null) updateDisplaySubcomponents();
      },
    );
  }

  void addUserResponse() {
    // Remove the components that are not selected
    removeUnselectedComponents();
    // add it to the user response
    setSubcomponent = displaySubcomponents.toList();
    print('The selected question set value is $selectedQuestionSetValue');

    userInput.addEntries(
      [
        MapEntry(
          displayTitle,
          selectedQuestionSetValue,
        )
      ],
    );
    print('The user input value is ${userInput.toString()}');
  }

  void removeUnselectedComponents() {
    for (var preference in selectedQuestionSetValue.preferences) {
      if (preference.components != null) {
        preference.components!
            .removeWhere((element) => (element.isChecked == false));
      }
      preference.subComponents!
          .removeWhere((element) => (element.response == null));
    }
  }

  void updateSubcomponentResponse(
    SubComponent subComponents,
    String response,
  ) {
    displaySubcomponents
        .firstWhere((subComponent) => subComponent == subComponents)
        .response = response;
    update();
  }

  void calculateFinalScoring() async {
    void printScoring() {
      for (var questionset in userInput.entries) {
        if (questionset.key == 'patientDetails')
          continue;
        else {
          QuestionSet value = (questionset.value as QuestionSet);
          print(value.heading!.scoring.toString());
          print('The preferences count is is ${value.preferences}');
          for (var preference in value.preferences) {
            print(
                'The subcomponent count is ${preference.subComponents?.length.toString()}');
          }
        }
      }
    }

    print('Before Updation');
    printScoring();
    for (var userInput in userInput.entries) {
      if (userInput.key == 'patientDetails') continue;
      QuestionSet questionSet = userInput.value;
      // TODO: Check whether to make it nullable and work with non-null condition
      Heading heading = questionSet.heading!;
      Scoring scoring = heading.scoring!;
      List<Preference> preferenceList = questionSet.preferences;

      // TODO: FUTURE: make a getter for the scoring within the question set itself

      for (var preference in preferenceList) {
        for (var subcomponent in preference.subComponents!) {
          switch (subcomponent.response) {
            case 'Dependent':
              scoring.dependent++;
              break;
            case 'Independent':
              scoring.independent++;
              break;
            case 'Needs Assistance':
              scoring.partiallyDependent++;
              break;
            case 'Not Applicable':
              break;
            default:
              break;
          }
        }
      }
    }
    print('after updation $userInput');
    printScoring();
    return;
  }

  // function to check whether is in between a range
  bool isInRange(int value, int min, int max) => value >= min && value <= max;

  String isMaletoString(bool value) => (value) ? 'Male' : 'Female';

  bool stringToIsMale(String value) => (value == 'Male') ? true : false;

  // function to check whether it is male or female
  //Null represents  applicable for both male and female
  bool isSameGender(bool? isMale) => (isMale == null)
      ? true
      : ((isMaletoString(isMale)) == gender)
          ? true
          : false;

  void initialEliminationFunction({required int age, required bool isMale}) {
    questions.entries.forEach(
      (questionSet) {
        questionSet.value.preferences.forEach(
          (preference) {
            // TODO: Check the working at last.. I guess || symbol should be used instead of &&
            preference.subComponents!.removeWhere(
              (subComponent) => !(isInRange(
                    age,
                    subComponent.minAge,
                    subComponent.maxAge,
                  ) &&
                  (isSameGender(subComponent.isMale))),
            );
          },
        );
      },
    );
  }

  selectGender(String value) {
    gender = value;
    update();
  }

  selectOrthosesOrProtheses(String value) {
    if (value == 'No') {
      hasOrthoProsthesis = false;
    } else {
      hasOrthoProsthesis = true;
    }
    selectOrthoses = value;

    update();
  }
}
