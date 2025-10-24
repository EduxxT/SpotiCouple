import 'package:flutter/material.dart';
import 'package:spoticouple/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
    child: Column(children: [
      //Logo
      DrawerHeader(
        child: Center(
          child: Icon(
            Icons.music_note,
            size: 100,
            color: Theme.of(context).colorScheme.inversePrimary,
            ),
        ),
      ),

      // Barra del Home
      Padding(
        padding:const EdgeInsets.only(left: 25.0, top: 10),
        child: ListTile(
          title: const Text("H O M E"),
          leading: const Icon(Icons.home),
          // POP para q se cierre el drawer
          onTap: () => Navigator.pop(context),
        ),
      )

      // Barra del settings
      ,Padding(
        padding:const EdgeInsets.only(left: 25.0, top: 4),
        child: ListTile(
          title: Text("S E T T I N G S"),
          leading: Icon(Icons.settings),
          // POP para q se cierre el drawer
          onTap: () {
            Navigator.pop(context);

            Navigator.push(context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
          // POP para settings

        ),
      )
    ],
    ),
  );
  
  }
}