import 'package:flutter/material.dart';

class CoreScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isDrawer;
  final bool isAppBar;
  final bool isResizeToAvoidBottomInset;
  final Widget? drawer; // Custom drawer content
  final Widget? footer; // Custom footer content
  final Color? appBarBackgroundColor; // AppBar background color
  final Color? appBarForegroundColor; // AppBar text and icons color
  final double? appBarElevation; // AppBar elevation
  final TextStyle? appBarTitleStyle; // AppBar title text style
  final IconThemeData? appBarIconTheme; // AppBar icon theme
  final bool? centerTitle; // Whether to center the AppBar title

  CoreScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.isAppBar = true,
    required this.isDrawer,
    required this.isResizeToAvoidBottomInset,
    this.drawer,
    this.footer,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.appBarElevation,
    this.appBarTitleStyle,
    this.appBarIconTheme,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBar
          ? AppBar(
        title: Text(
          title,
          style: appBarTitleStyle ?? Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: actions,
        backgroundColor: appBarBackgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: appBarForegroundColor ?? Theme.of(context).appBarTheme.foregroundColor,
        elevation: appBarElevation ?? Theme.of(context).appBarTheme.elevation,
        iconTheme: appBarIconTheme ?? Theme.of(context).appBarTheme.iconTheme,
        centerTitle: centerTitle ?? Theme.of(context).appBarTheme.centerTitle,
      )
          : null,
      resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
      drawer: isDrawer ? (drawer ?? _buildDefaultDrawer(context)) : null,
      body: Column(
        children: [
          Expanded(child: body),
          footer ?? _buildDefaultFooter(context),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  // Default drawer content
  Widget _buildDefaultDrawer(BuildContext context) {
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic here
            },
          ),
        ],
      ),
    );
  }

  // Default footer content
  Widget _buildDefaultFooter(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
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