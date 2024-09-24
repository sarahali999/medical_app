import 'package:flutter/material.dart';
import 'news_model.dart';
import '../languages/lang.dart';

class NewsDetailModal extends StatelessWidget {
  final Article article;
  final ScrollController controller;
  final Language selectedLanguage;

  const NewsDetailModal({
    Key? key,
    required this.article,
    required this.controller,
    required this.selectedLanguage,
  }) : super(key: key);

  TextDirection getTextDirection() {
    return selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: getTextDirection(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.05),
            topRight: Radius.circular(screenWidth * 0.05),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  child: Image(
                    image: NetworkImage(article.imageFullUrl),
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        height: screenHeight * 0.3,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  article.titleNews,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  article.theContent,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}