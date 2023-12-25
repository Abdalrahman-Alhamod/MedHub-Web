import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../Cubits/Products/products_cubit.dart';
import '../helpers/search_by_dialog.dart';

class CustomeTextField extends StatefulWidget {
  const CustomeTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onTap,
    this.onSubmit,
    this.isSearchBar = false,
    this.floatingLabelFontSize = 16,
    this.maxLines = 1,
    this.textDirection
  });
  final bool obscureText;
  final String hintText;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onSubmit;
  final bool isSearchBar;
  final double floatingLabelFontSize;
  final int maxLines;
  final TextDirection? textDirection;

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  bool _enableObscureText = false;
  TextEditingController? _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    _enableObscureText = widget.obscureText;
    if (widget.isSearchBar) {
      _controller!.text =
          BlocProvider.of<ProductsCubit>(context).searchBarContent;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _enableObscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: _controller,
      onFieldSubmitted: widget.onSubmit,
      onTapOutside: _handleOnTapOutside,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: widget.hintText,
        prefixIcon: widget.onTap != null
            ? IconButton(
                onPressed: widget.onTap,
                icon: Icon(widget.prefixIcon),
              )
            : Icon(
                widget.prefixIcon,
                color: AppColors.primaryColor,
              ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: _enableObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _enableObscureText = !_enableObscureText;
                  });
                },
              )
            : widget.isSearchBar
                ? SizedBox(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _controller!.clear();
                              BlocProvider.of<ProductsCubit>(context)
                                  .searchBarContent = "";
                            });
                          },
                        ),
                        Container(
                          height: 30, // Adjust the height as needed
                          width: 1, // Adjust the width as needed
                          color: Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.tune),
                          onPressed: () {
                            setState(() {
                              showSearchByDialog();
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        floatingLabelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: widget.floatingLabelFontSize),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: widget.textDirection,
    );
  }
}

void _handleOnTapOutside(pointerDownEvent) {
  Get.focusScope!.unfocus();
}
