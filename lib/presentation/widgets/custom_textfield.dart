import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final FormFieldValidator validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
    required this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isPassword;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isPassword,
        validator: widget.validator,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Color(0x80FFFFFF),
            fontSize: 14,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.white,
            size: 20,
          ),
         // condtion if the keyboardtype is password, this will triggered
          suffixIcon: widget.keyboardType == TextInputType.visiblePassword
              ? IconButton(
                  icon: Icon(
                    _isPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPassword = !_isPassword;
                    });
                  },
                )
              : null,
          hintStyle: const TextStyle(
            color: Color(0x80FFFFFF),
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0x80FFFFFF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0x80FFFFFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}
