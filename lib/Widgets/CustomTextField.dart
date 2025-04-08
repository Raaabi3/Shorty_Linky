import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onValidUrlSubmitted;
  final double borderRadius;

  const CustomTextField.urlInput({
    super.key,
    required this.hintText,
    this.onValidUrlSubmitted,
    this.borderRadius = 12.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  bool _validateUrl(String url) {
    if (url.isEmpty) return false;

    final urlPattern =
        r'^(https?:\/\/)'
        r'([a-z0-9-]+\.)+[a-z]{2,}'
        r'(\/[^\s]*)?$';

    return RegExp(urlPattern, caseSensitive: false).hasMatch(url);
  }

  void _handleSubmitted(String url) {
    final trimmedValue = url.trim();
    if (trimmedValue.isEmpty) {
      setState(() => _errorText = "URL cannot be empty");
      return;
    }

    if (_validateUrl(trimmedValue)) {
      setState(() => _errorText = null);
      widget.onValidUrlSubmitted?.call(trimmedValue);
    } else {
      setState(
        () =>
            _errorText = "Enter a valid URL (e.g start with http:// end with .com)",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            setState(() => _errorText = null);
          },
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorText: _errorText,
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.go,
      onSubmitted: _handleSubmitted,
      onChanged: (value) {
        if (_errorText != null) {
          setState(() => _errorText = null);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
