import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoticouple/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S E T T TI N G S'),
      ),
    body: Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Dark Mode",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),

          CupertinoSwitch(
            value: 
              Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) =>
              Provider.of<ThemeProvider>(context, listen:false)
                  .toggleTheme(),
          ),
        ],
      ),
    ),
    );
  }
}