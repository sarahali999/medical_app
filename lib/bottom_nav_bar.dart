import 'package:flutter/material.dart';
import 'constant.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    switch(index) {
      case 0:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: 300,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("QR Code Feature"),
                    SizedBox(height: 120),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF80CBC4)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("إغلاق"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      case 1:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
      // Handle edit functionality or navigation
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BottomNavItem(
            title: "QR",
            iconData: Icons.qr_code,
            isActive: _selectedIndex == 0,
            press: () => _onItemTapped(0),
          ),
          BottomNavItem(
            title: "الرئيسية",
            iconData: Icons.home_outlined,
            isActive: _selectedIndex == 1,
            press: () => _onItemTapped(1),
          ),
          BottomNavItem(
            title: "التعديلات",
            iconData: Icons.edit,
            isActive: _selectedIndex == 2,
            press: () => _onItemTapped(2),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function()? press;
  final bool isActive;

  const BottomNavItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            iconData,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: isActive ? kActiveIconColor : kTextColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Changa-VariableFont_wght',
            ),
          ),
        ],
      ),
    );
  }
}
