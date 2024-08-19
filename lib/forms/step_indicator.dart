import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../languages/lang.dart';  // Make sure to import your language file

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Language selectedLanguage;

  StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.selectedLanguage
  });

  @override
  Widget build(BuildContext context) {
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
                return _buildStep(context, index, isActive, isCurrent);
              }),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (currentStep + 1) / totalSteps,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5CBBE3)),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int index, bool isActive, bool isCurrent) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF5CBBE3) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Color(0xFF5CBBE3) : Colors.grey[300]!,
              width: 2,
            ),
            boxShadow: isCurrent ? [BoxShadow(color: Color(0xFF5CBBE3).withOpacity(0.3), blurRadius: 8, spreadRadius: 2)] : [],
          ),
          child: Center(
            child: SvgPicture.asset(
              _getIconPath(index),
              color: isActive ? Colors.white : Colors.grey[400],
              width: 28,
              height: 28,
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
        SizedBox(height: 8),
        Text(
          _getLocalizedStepTitle(index),
          style: TextStyle(
            color: isActive ? Color(0xFF5CBBE3) : Colors.grey[600],
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getIconPath(int index) {
    switch (index) {
      case 0: return 'assets/icons/person.svg';
      case 1: return 'assets/icons/medh.svg';
      case 2: return 'assets/icons/close.svg';
      default: return 'assets/icons/close.svg';
    }
  }

  String _getLocalizedStepTitle(int index) {
    switch (index) {
      case 0:
        return _getLocalizedText('شخصي', 'شخصی', 'Personal', 'کەسی', '');
      case 1:
        return _getLocalizedText('طبي', 'پزشکی', 'Medical', 'پزیشکی', '');
      case 2:
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