import 'package:flutter/material.dart';

class CoreScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isDrawer;
  bool isAppBar;
  final bool isResizeToAvoidBottomInset;

  CoreScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.floatingActionButton,
      this.actions,
      this.isAppBar = true,
      required this.isDrawer,
      required this.isResizeToAvoidBottomInset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBar
          ? AppBar(
              title: Text(
                title,
              ),
              actions: actions,
            )
          : null,
      resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
      drawer: isDrawer ? _buildDrawer(context) : null,
      body: Column(
        children: [
          Expanded(child: body),
          _buildFooter(context),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(8.0),
      child: const Center(
        child: Text(
          '© 2025 My App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
