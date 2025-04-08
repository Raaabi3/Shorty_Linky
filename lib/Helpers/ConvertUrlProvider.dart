import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:security_camera/Services/ConvertUrlService.dart';

import '../Models/ShortenedUrlResponse.dart';

class Converturlprovider with ChangeNotifier {
  ShortenedUrlResponse? _shortenedData;
  ShortenedUrlResponse? get shortenedData => _shortenedData;

  Future<void> shortenUrlExample(String url) async {
    try {
      final response = await shortenUrlService(url);
      final json = jsonDecode(response.body);
      final wrapper = ShortenUrlWrapper.fromJson(json);
      _shortenedData = wrapper.data;
      print("Shortened URL: ${_shortenedData!.shortened}");

      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }
}
