import 'package:flutter/material.dart';
import 'package:shopping/presentation/utils/Palette.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final FormFieldValidator validator;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
    required this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPassword;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isPassword,
        validator: widget.validator,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon:
              widget.keyboardType == TextInputType.visiblePassword
                  ? Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      icon: Icon(
                        _isPassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 170, 170, 170),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPassword = !_isPassword;
                        });
                      },
                    ),
                  )
                  : null,
          contentPadding: const EdgeInsets.all(23),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 200, 200, 200),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Pallete.whiteColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(color: Colors.redAccent, height: 2),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.labelText,
        ),
      ),
    );
  }
}
