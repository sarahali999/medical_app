import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextStyle textStyle;
  final IconData? prefixIcon;
  final double? width;
  final double? height;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextField(
      this.labelText,
      this.controller, {
        this.textStyle = const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        this.prefixIcon,
        this.width,
        this.height,
        this.keyboardType = TextInputType.text,
        this.inputFormatters,
      });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.only(top: _isFocused ? 12 : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: _isFocused
                          ? Color(0xFF5BB9AE).withOpacity(0.3)
                          : Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: widget.controller,
                  style: widget.textStyle,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    labelText: widget.labelText, // Use widget.labelText here
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF5BB9AE)), // Assuming _primaryColor is Color(0xFF5BB9AE)
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                  onTap: () {
                    setState(() => _isFocused = true);
                    _animationController.forward();
                  },
                  onEditingComplete: () {
                    setState(() => _isFocused = false);
                    _animationController.reverse();
                  },
                ),
              ),
              if (_isFocused)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      height: 2,
                      color: Color(0xFF5BB9AE),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}