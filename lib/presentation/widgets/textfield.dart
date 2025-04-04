import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isNumber;
  final FormFieldValidator validator;
  final int? maxLiness;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
    this.isNumber = false,
    required this.validator,
    this.maxLiness = 1,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          TextFormField(
            inputFormatters: [
              widget.isNumber
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.singleLineFormatter,
            ],
            maxLines: widget.maxLiness,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _isPassword,
            validator: widget.validator,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              // labelText: widget.labelText,
              labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              // prefixIcon: Icon(
              //   widget.icon,
              //   color: const Color.fromARGB(255, 0, 0, 0),
              //   size: 20,
              // ),
              // condtion if the keyboardtype is password, this will triggered
              suffixIcon:
                  widget.keyboardType == TextInputType.visiblePassword
                      ? IconButton(
                        icon: Icon(
                          _isPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPassword = !_isPassword;
                          });
                        },
                      )
                      : null,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
