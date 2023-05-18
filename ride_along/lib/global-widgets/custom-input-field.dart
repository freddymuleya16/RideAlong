import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/main-controller.dart';

class CustomInputField extends StatefulWidget {
  final bool isDark;
  final String name;
  final TextEditingController? controller;
  final bool obscure;

  final String? errorText;

  final bool isReadOnly;

  var onTap;
  CustomInputField(
      {super.key,
      required this.isDark,
      required this.name,
      this.controller,
      this.obscure = false,
      this.errorText,
      this.isReadOnly = false,
      this.onTap});
  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isDark = false;
  Duration _animationSpeed = const Duration(milliseconds: 666);
  double _opacity = 0.0;
  EdgeInsets _padding = const EdgeInsets.only(top: 33);

  var _isObscure = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDark = widget.isDark;
      _isObscure = widget.obscure;
    });
    print({'freddy', isDark});
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _padding = EdgeInsets.zero;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 80,
      child: TextField(
          readOnly: widget.isReadOnly,
          controller: widget.controller,
          obscureText: _isObscure,
          textAlign: TextAlign.left,

          //maxLength: 25,
          onTap: widget.onTap,
          style: GoogleFonts.ubuntu(
            color: !isDark ? kTextColorDark : kTextColorLight,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            decorationColor: !isDark ? kTextColorDark : kTextColorLight,
          ),
          cursorColor: !isDark ? kTextColorDark : kTextColorLight,
          //cursorHeight: 35,
          decoration: InputDecoration(
              suffixIcon: widget.obscure
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: isDark
                            ? kBackgroundColor.withOpacity(0.75)
                            : kBackgroundColorDark.withOpacity(0.75),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDark
                      ? kBackgroundColor.withOpacity(0.75)
                      : kBackgroundColorDark.withOpacity(0.75),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDark
                      ? kBackgroundColor.withOpacity(0.75)
                      : kBackgroundColorDark.withOpacity(0.75),
                ),
              ),
              labelStyle: GoogleFonts.ubuntu(
                  color: !isDark
                      ? kBackgroundColorDark.withOpacity(0.75)
                      : kTextColorLight.withOpacity(0.75),
                  fontSize: 14.0),
              hintStyle: GoogleFonts.ubuntu(
                  color: isDark
                      ? kBackgroundColorDark.withOpacity(0.75)
                      : kTextColorLight.withOpacity(0.75),
                  fontSize: 21.0),
              labelText: widget.name,
              errorText: widget.errorText)),
    );
  }
}
