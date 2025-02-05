import 'package:flutter/material.dart';
import 'package:personal_sos_app/widgets/all_contact.dart';
import 'package:personal_sos_app/widgets/home_widget.dart';
import 'package:personal_sos_app/utils/colors.dart';
import 'package:personal_sos_app/widgets/new_contact.dart';
import 'package:personal_sos_app/widgets/settings_widget.dart';

class TabScreen extends StatefulWidget {
  static const routeName = "/tab-screen";

  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeWidget(),
    NewContactWidget(),
    AllContactWidget(),
    SettingsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/home-bg-2.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: _pages[_selectedIndex])),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30.0),
        // color: primaryColor,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 0),
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "", 0),
            _buildNavItem(Icons.person_add_alt_1, "", 1),
            _buildNavItem(Icons.people_rounded, "", 2),
            _buildNavItem(Icons.sync_alt, "", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? primaryColor : Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
