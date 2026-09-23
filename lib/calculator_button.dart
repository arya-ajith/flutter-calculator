import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String? text;
  final String? image;

  final double width;
  final double height;

  final Color backgroundColor;
  final Color hoverColor;
  final Color pressedColor;

  final VoidCallback? onPressed;

  const CalculatorButton({
    super.key,
    this.text,
    this.image,
    this.width = 57,
    this.height = 57,
    this.backgroundColor = Colors.white,
    this.hoverColor = const Color(0xFFBCBCBC),
    this.pressedColor = const Color(0xFFA7A7A7),
    this.onPressed,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: GestureDetector(
        onTap: widget.onPressed,

        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },

        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },

        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },

        child: Container(
          width: widget.width,
          height: widget.height,

          decoration: BoxDecoration(
            color: isPressed
                ? widget.pressedColor
                : isHovered
                ? widget.hoverColor
                : widget.backgroundColor,

            borderRadius: BorderRadius.circular(100),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
              ),
            ],
          ),

          child: Center(
            child: widget.image != null
                ? isPressed
                      ? Image.asset(widget.image!, color: Colors.white)
                      : Image.asset(widget.image!)
                : Text(
                    widget.text!,
                    style: TextStyle(
                      fontSize: 20,
                      color: isPressed ? Colors.white : Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
