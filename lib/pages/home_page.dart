import 'package:flutter/material.dart';
import 'package:spoticouple/components/drawer_component.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('S P O T I C O U P L E')),
      drawer: const MyDrawer(),
    );
  }
}