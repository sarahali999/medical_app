import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constant.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final String svgScr;
  final bool isActive;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.press,
    required this.svgScr,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: 200,
        height: 200,
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView( // Wrap the Column in SingleChildScrollView
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        svgScr,
                        color: isActive ? kActiveIconColor : kTextColor,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 20,
                          fontFamily: 'Changa-VariableFont_wght',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}