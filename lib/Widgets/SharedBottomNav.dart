import 'package:flutter/material.dart';
import 'package:security_camera/Models/url_history.dart';

enum AppPage { home, results }

class SharedBottomNav extends StatelessWidget {
  final AppPage currentPage;
  final bool isResultEnabled;
  final void Function(AppPage) onTabSelected;
  final List<UrlHistory> history; 

  const SharedBottomNav({
    super.key,
    required this.currentPage,
    required this.isResultEnabled,
    required this.onTabSelected,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage.index,
      onTap: (index) {
        final selectedPage = AppPage.values[index];
        if (selectedPage == AppPage.results && history.isEmpty) {
          _showNoHistoryDialog(context); 
          return;
        }
        if (selectedPage == AppPage.results && !isResultEnabled) return;
        onTabSelected(selectedPage);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentPage == AppPage.home ? Colors.blue : Colors.grey, 
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.link,
            color: currentPage == AppPage.results ? Colors.blue : Colors.grey, 
          ),
          label: 'Results',
        ),
      ],
    );
  }

  void _showNoHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Previous Url'),
          content: const Text('There is no previous history to show please convert a link to proceed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('OK',style: TextStyle(color:Colors.blue
              )),
            ),
          ],
        );
      },
    );
  }
}
