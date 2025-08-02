import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatefulWidget {
  final Widget child;

  const Navigation({Key? key, required this.child}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool _isKeyboardOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isOpen = bottomInset > 0;
    if (isOpen != _isKeyboardOpen) {
      setState(() {
        _isKeyboardOpen = isOpen;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/settings');
        break;
      case 2:
        context.go('/user-guide');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _isKeyboardOpen
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: appbarcolor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xff005EB8), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    navItem(icon: Icons.help, label: 'User Guide', index: 2),
                    navItem(icon: Icons.home, label: 'Home', index: 0),
                    navItem(icon: Icons.settings, label: 'Settings', index: 1),
                  ],
                ),
              ),
            ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool selected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? Colors.white : Colors.white60,
            size: 35,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: selected ? Colors.white : Colors.white60,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
