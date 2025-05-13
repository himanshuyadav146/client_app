import 'package:client_app/core/index.dart';
import 'package:client_app/views/index.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // A helper method to build list tile options
  Widget _buildListTile({
    required String title,
    required VoidCallback onTap,
    Icon? leadingIcon,
  }) {
    return ListTile(
      leading:
          leadingIcon ?? const Icon(Icons.arrow_forward_ios), // Default icon
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Settings',
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
      appBarBackgroundColor: Theme.of(context).primaryColor,
      appBarForegroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Account option
            _buildListTile(
              title: 'Account',
              onTap: () {
                // Handle Account navigation (optional)
              },
              leadingIcon: const Icon(Icons.person),
            ),
            const Divider(),

            _buildListTile(
              title: 'Order History',
              onTap: () {
                // Handle Account navigation (optional)
              },
              leadingIcon: const Icon(Icons.book_online),
            ),
            const Divider(),

            // Privacy Policy option
            _buildListTile(
              title: 'Privacy Policy',
              onTap: () {
                // Navigate to Privacy Policy screen
              },
              leadingIcon: const Icon(Icons.lock),
            ),
            const Divider(),

            // About Us option
            _buildListTile(
              title: 'About Us',
              onTap: () {
                // Navigate to Privacy Policy screen
              },
              leadingIcon: const Icon(Icons.info),
            ),
            const Divider(),

            // Rate Us option
            _buildListTile(
              title: 'Rate Us',
              onTap: () {
                // Handle Rate Us (optional)
              },
              leadingIcon: const Icon(Icons.star),
            ),
            const Divider(),

            // Logout option
            _buildListTile(
              title: 'Logout',
              onTap: () {
                // Logout and go back to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneNoView()),
                );
              },
              leadingIcon: const Icon(Icons.exit_to_app, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
