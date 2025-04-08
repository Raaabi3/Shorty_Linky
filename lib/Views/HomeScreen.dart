import 'package:flutter/material.dart';
import 'package:security_camera/Controllers/UrlHistoryController%20.dart';
import 'package:security_camera/Views/ResultScreen.dart';
import 'package:security_camera/Widgets/CustomText.dart';
import 'package:security_camera/Widgets/CustomTextField.dart';

class Homescreen extends StatefulWidget {
  final UrlHistoryController controller;
  
  const Homescreen({super.key, required this.controller});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String _shortenUrl(String originalUrl) {
    // Replace with actual API call
    return 'https://short.ly/${originalUrl.hashCode.toRadixString(36)}';
  }

  void _handleValidUrl(String url) {
    final shortenedUrl = _shortenUrl(url);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultscreen(
          originalUrl: url,
          shortenedUrl: shortenedUrl,
          controller: widget.controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.title(text: "Shorten Your Links"),
            const SizedBox(height: 8),
            CustomText.subtitle(
              text: "Tired of Long Links? This app provides easy-to-use URL shortening",
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset("assets/images/www2.gif", fit: BoxFit.contain),
                  CustomTextField.urlInput(
                    hintText: "Paste URL here...",
                    onValidUrlSubmitted: _handleValidUrl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}