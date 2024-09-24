import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../languages/lang.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Language selectedLanguage;

  StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Define container heights based on screen height
    double circleHeight = screenHeight * 0.06;
    double iconSize = screenHeight * 0.03;
    double sizedBoxHeight = screenHeight * 0.01;

    bool isRightToLeft = selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish;

    return Directionality(
      textDirection: isRightToLeft ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(totalSteps, (index) {
                bool isActive = index <= currentStep;
                bool isCurrent = index == currentStep;
                return _buildStep(context, index, isActive, isCurrent, circleHeight, iconSize, sizedBoxHeight);
              }),
            ),
            SizedBox(height: sizedBoxHeight * 2), // Adjusted for visual balance
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (currentStep + 1) / totalSteps,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5BB9AE)),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int index, bool isActive, bool isCurrent, double circleHeight, double iconSize, double sizedBoxHeight) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: circleHeight,
          width: circleHeight,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF5BB9AE)
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Color(0xFF5BB9AE)
                  : Colors.grey[300]!,
              width: 2,
            ),
            boxShadow: isCurrent ? [BoxShadow(color: Color(0xFF5BB9AE).withOpacity(0.3), blurRadius: 8, spreadRadius: 2)] : [],
          ),
          child: Center(
            child: SvgPicture.asset(
              _getIconPath(index),
              color: isActive ? Colors.white : Colors.grey[400],
              width: iconSize,
              height: iconSize,
            ),
          ),
        ).animate()
            .scale(
          begin: Offset(isCurrent ? 0.9 : 1, isCurrent ? 0.9 : 1),
          end: Offset(isCurrent ? 1.1 : 1, isCurrent ? 1.1 : 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
            .then()
            .scale(
          begin: Offset(isCurrent ? 1.1 : 1, isCurrent ? 1.1 : 1),
          end: Offset(1, 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        SizedBox(height: sizedBoxHeight),
        Text(
          _getLocalizedStepTitle(index),
          style: TextStyle(
            color: isActive ? Color(0xFF5BB9AE)
                : Colors.grey[600],
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Zain',
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getIconPath(int index) {
    switch (index) {
      case 0: return 'assets/icons/person.svg';
      case 1: return 'assets/icons/email.svg'; // New icon for Account step
      case 2: return 'assets/icons/medh.svg';
      case 3: return 'assets/icons/close.svg';
      default: return '';
    }
  }

  String _getLocalizedStepTitle(int index) {
    switch (index) {
      case 0:
        return _getLocalizedText('شخصي', 'شخصی', 'Personal', 'کەسی', '');
      case 1:
        return _getLocalizedText('حساب', 'حساب', 'Account', 'هەژمار', '');
      case 2:
        return _getLocalizedText('طبي', 'پزشکی', 'Medical', 'پزیشکی', '');
      case 3:
        return _getLocalizedText('طوارئ', 'اورژانسی', 'Emergency', 'کتوپڕ', '');
      default:
        return '';
    }
  }

  String _getLocalizedText(String arabic, String persian, String english, String kurdish, String defaultText) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.English:
        return english;
      case Language.Kurdish:
        return kurdish;
      default:
        return defaultText;
    }
  }
}