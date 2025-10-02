import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StylishTextField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeHolder;
  final IconData? icon;
  final ValueChanged<String>? onSubmitted;
  const StylishTextField({
    super.key,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.placeHolder,
    this.icon,
    this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() => _StylishTextFieldState();
}

class _StylishTextFieldState extends State<StylishTextField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 55.0,
      child: CupertinoTextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          border: Border.all(color: Color(0xFFA8A8A9)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0, vertical: 16.0),
        placeholder: widget.placeHolder,
        prefix: widget.icon != null
          ? Padding(
            padding: EdgeInsetsGeometry.only(left: 12.0),
            child: Icon(widget.icon, color: Color(0xFF626262)),
          )
          : null,
          suffix: widget.isPassword
            ? IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: _obscure
                ? Icon(Icons.visibility_outlined)
                : Icon(Icons.visibility_off_outlined),
            )
            : null,
        placeholderStyle: TextStyle(
          color: Color(0xFF676767),
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 2.0,
        ),
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.isPassword ? _obscure : false,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}