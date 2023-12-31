import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunapos_akpsi/helper/formatter.dart';

class FormInput extends StatefulWidget {
  FormInput({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isPassword,
    this.icon,
    this.isDisabled,
    this.onChanged,
    this.uppercaseOnly,
    this.focusNode,
    this.isNumberOnly,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(dynamic) validator;
  final bool? isPassword;
  final bool? isDisabled;
  final String? Function(dynamic)? onChanged;
  final Widget? icon;
  final bool? uppercaseOnly;
  final FocusNode? focusNode;
  bool? isNumberOnly;

  @override
  State<FormInput> createState() {
    return _FormInputState();
  }
}

class _FormInputState extends State<FormInput> {
  bool passwordVisible = true;

  bool togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
    return passwordVisible;
  }

  @override
  void initState() {
    if (widget.isPassword == true) {
      togglePasswordVisibility();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      inputFormatters: (widget.uppercaseOnly != null)
          ? [
              UpperCaseTextFormatter(),
            ]
          : (widget.isNumberOnly == true)
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]
              : null,
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      enabled: widget.isDisabled == true ? false : true,
      controller: widget.controller,
      obscureText: widget.isPassword == true ? !passwordVisible : false,
      validator: widget.validator,
      focusNode: widget.focusNode, // Use focusNode here
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    togglePasswordVisibility();
                  });
                },
                icon: passwordVisible == true
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xFF88939E),
          fontSize: 16,
        ),
        filled: true,
        fillColor: widget.isDisabled == true
            ? const Color.fromARGB(255, 241, 238, 252)
            : Colors.white,
        errorStyle: const TextStyle(
          height: 0,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderSide:
              widget.isDisabled == true ? BorderSide.none : const BorderSide(),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefix: const Padding(padding: EdgeInsets.only(left: 10.0)),
        suffix: const Padding(padding: EdgeInsets.only(right: 10.0)),
      ),
    );
  }
}
