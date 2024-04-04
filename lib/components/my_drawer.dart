import 'package:enjoy_food/components/my_drawer_tile.dart';
import 'package:enjoy_food/pages/settingsPage.dart';
import 'package:enjoy_food/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list tile
          MyDrawerTile(
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
            text: "H O M E",
          ),
          // settings list tile
          MyDrawerTile(
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            text: "S E T T I N G S",
          ),
          const Spacer(),
          // logout list tile
          MyDrawerTile(
            icon: Icons.logout,
            onTap: () {
              logout();
            },
            text: "L O G O U T",
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
