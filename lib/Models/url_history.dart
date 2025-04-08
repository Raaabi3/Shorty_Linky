import 'package:hive/hive.dart';

part 'url_history.g.dart';

@HiveType(typeId: 0, adapterName: 'UrlHistoryAdapter')
class UrlHistory {
  @HiveField(0)
  final String site;
  
  @HiveField(1)
  final String originalUrl;
  
  @HiveField(2)
  final String shortUrl;
  
  @HiveField(3, defaultValue: null)
  final DateTime lastChecked;

  UrlHistory({
    required this.site,
    required this.originalUrl,
    required this.shortUrl,
    required this.lastChecked,
  });
}