class ShortenUrlWrapper {
  final ShortenedUrlResponse data;

  ShortenUrlWrapper({required this.data});

  factory ShortenUrlWrapper.fromJson(Map<String, dynamic> json) {
    return ShortenUrlWrapper(
      data: ShortenedUrlResponse.fromJson(json['data']),
    );
  }
}

class ShortenedUrlResponse {
  final String message;
  final String hash;
  final String url;
  final String shortened;

  ShortenedUrlResponse({
    required this.message,
    required this.hash,
    required this.url,
    required this.shortened,
  });

  factory ShortenedUrlResponse.fromJson(Map<String, dynamic> json) {
    return ShortenedUrlResponse(
      message: json['message'],
      hash: json['hash'],
      url: json['url'],
      shortened: json['shortened'],
    );
  }
}
