import 'package:flutter/material.dart';

enum AppPage { home, results }

class SharedBottomNav extends StatelessWidget {
  final AppPage currentPage;
  final bool isResultEnabled;
  final void Function(AppPage) onTabSelected;

  const SharedBottomNav({
    super.key,
    required this.currentPage,
    required this.isResultEnabled,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage.index,
      onTap: (index) {
        final selectedPage = AppPage.values[index];
        if (selectedPage == AppPage.results && !isResultEnabled) return;
        onTabSelected(selectedPage);
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.link,
            color: isResultEnabled ? null : Colors.grey,
          ),
          label: 'Results',
        ),
      ],
    );
  }
}
