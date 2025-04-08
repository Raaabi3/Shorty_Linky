import 'package:hive/hive.dart';
import 'package:security_camera/Models/url_history.dart';

class UrlHistoryController {
  late Box<UrlHistory> _urlHistoryBox;

  Future<void> init() async {
    try {
      await Hive.deleteBoxFromDisk('urlHistoryBox');
      _urlHistoryBox = await Hive.openBox<UrlHistory>('urlHistoryBox');
    } catch (e) {
      print('Error initializing Hive: $e');
      await Hive.deleteFromDisk();
      _urlHistoryBox = await Hive.openBox<UrlHistory>('urlHistoryBox');
    }
  }

  Future<void> addUrl({
    required String originalUrl,
    required String shortUrl,
  }) async {
    final newEntry = UrlHistory(
      site: _extractDomain(originalUrl),
      originalUrl: originalUrl,
      shortUrl: shortUrl,
      lastChecked: DateTime.now(),
    );
    await _urlHistoryBox.add(newEntry);
  }

  List<UrlHistory> getHistory() => _urlHistoryBox.values.toList().reversed.toList();

  Stream<BoxEvent> watchChanges() => _urlHistoryBox.watch();

  Future<void> clearHistory() async => await _urlHistoryBox.clear();

  String _extractDomain(String url) {
    try {
      if (!url.startsWith('http')) url = 'https://$url';
      final uri = Uri.parse(url);
      return uri.host.replaceAll('www.', '').split('.')[0];
    } catch (e) {
      return "Link";
    }
  }

  Future<void> deleteItem(int key) async {
    await _urlHistoryBox.delete(key);
  }

  Future<void> deleteItems(List<int> keys) async {
    await _urlHistoryBox.deleteAll(keys);
  }

  Map<int, UrlHistory> getHistoryMap() {
  return _urlHistoryBox.toMap().map(
    (key, value) => MapEntry(key as int, value),
  );
}

}
