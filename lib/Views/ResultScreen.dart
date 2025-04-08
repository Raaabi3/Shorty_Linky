import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:security_camera/Controllers/UrlHistoryController%20.dart';
import 'package:security_camera/Models/url_history.dart';
import 'package:security_camera/Widgets/CustomText.dart';

class Resultscreen extends StatefulWidget {
  final String originalUrl;
  final String shortenedUrl;
  final UrlHistoryController controller;

  const Resultscreen({
    super.key,
    required this.originalUrl,
    required this.shortenedUrl,
    required this.controller,
  });

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  Set<int> _selectedItems = {};
  bool _isSelectMode = false;

  @override
  void initState() {
    super.initState();
    _saveCurrentUrl();
  }

  Future<void> _saveCurrentUrl() async {
    await widget.controller.addUrl(
      originalUrl: widget.originalUrl,
      shortUrl: widget.shortenedUrl,
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Copied to clipboard!")));
    });
  }

  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) _selectedItems.clear();
    });
  }

  void _toggleItemSelection(int key) {
    setState(() {
      if (_selectedItems.contains(key)) {
        _selectedItems.remove(key);
      } else {
        _selectedItems.add(key);
      }
      if (_selectedItems.isEmpty) _isSelectMode = false;
    });
  }

  Future<void> _deleteSelected() async {
    await widget.controller.deleteItems(_selectedItems.toList());
    setState(() {
      _selectedItems.clear();
      _isSelectMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
            _isSelectMode
                ? Text('${_selectedItems.length} selected')
                : CustomText.title2(text: "Shortened Link"),
        centerTitle: true,
        leading:
            _isSelectMode
                ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _toggleSelectMode,
                )
                : IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
        actions: _buildAppBarActions(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_isSelectMode) _buildCurrentUrlCard(),
          if (!_isSelectMode)
            Image.asset("assets/images/www3.gif", height: 200),
          Spacer(),
          _buildHistoryHeader(),
          Expanded(child: _buildHistoryList()),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSelectMode) {
      return [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _selectedItems.isNotEmpty ? _deleteSelected : null,
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.select_all),
          onPressed: _toggleSelectMode,
        ),
      ];
    }
  }

  Widget _buildCurrentUrlCard() {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Shortened URL",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.shortenedUrl,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () => _copyToClipboard(widget.shortenedUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText.subtitle(text: "Converted Links History"),
          if (!_isSelectMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await widget.controller.clearHistory();
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return StreamBuilder<BoxEvent>(
      stream: widget.controller.watchChanges(),
      builder: (context, snapshot) {
        final historyMap = widget.controller.getHistoryMap();
        final historyEntries = historyMap.entries.toList().reversed.toList();

        return ListView.builder(
          itemCount: historyEntries.length,
          itemBuilder: (context, index) {
            final entry = historyEntries[index];
            return _buildHistoryItem(entry.key, entry.value);
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(int key, UrlHistory item) {
    return InkWell(
      onLongPress: () {
        _toggleSelectMode();
        _toggleItemSelection(key);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        color: _selectedItems.contains(key) ? Colors.blue[100] : null,
        child: ListTile(
          leading:
              _isSelectMode
                  ? Checkbox(
                    value: _selectedItems.contains(key),
                    onChanged: (_) => _toggleItemSelection(key),
                  )
                  : _getSiteIcon(item.site),
          title: Text(item.shortUrl, overflow: TextOverflow.ellipsis),
          subtitle: Text(item.originalUrl, overflow: TextOverflow.ellipsis),
          trailing:
              _isSelectMode
                  ? null
                  : IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => widget.controller.deleteItem(key),
                  ),
          onTap: () {
            if (_isSelectMode) {
              _toggleItemSelection(key);
            } else {
              _copyToClipboard(item.shortUrl);
            }
          },
        ),
      ),
    );
  }

  Widget _getSiteIcon(String site) {
    switch (site.toLowerCase()) {
      case "google":
        return const Icon(Icons.search, color: Colors.red);
      case "youtube":
        return const Icon(Icons.play_circle_fill, color: Colors.red);
      case "twitter":
        return const Icon(Icons.trending_up, color: Colors.blue);
      case "github":
        return const Icon(Icons.code, color: Colors.black);
      default:
        return const Icon(Icons.link);
    }
  }
}
