import 'package:flutter/material.dart';
import 'package:shakti_contact/views/home_screen.dart';
import 'package:shakti_contact/views/profile/profile_screen.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  BottomBar({required this.onToggleTheme, required this.isDarkMode});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.favorite,
    Icons.notifications,
    Icons.person,
  ];

  final List<String> _labels = ["Home", "Favorite", "Notifications", "Profile"];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(
        onToggleTheme: widget.onToggleTheme,
        isDarkMode: widget.isDarkMode,
      ),
      Center(child: Text("Favorite Page", style: TextStyle(fontSize: 24))),
      Center(child: Text("Notifications Page", style: TextStyle(fontSize: 24))),
      //Center(child: Text("Profile Page", style: TextStyle(fontSize: 24))),
      ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    // if (index == 0) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder:
    //           (context) => HomeScreen(
    //             onToggleTheme: widget.onToggleTheme,
    //             isDarkMode: widget.isDarkMode,
    //           ),
    //     ),
    //   );
    // } else {
      setState(() => _selectedIndex = index);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            final isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () => _onTabTapped(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.indigo.shade100 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      _icons[index],
                      color: isSelected ? Colors.indigo : Colors.grey,
                    ),
                    SizedBox(width: isSelected ? 8 : 0),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child:
                          isSelected
                              ? Text(
                                _labels[index],
                                key: ValueKey(_labels[index]),
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                              : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
