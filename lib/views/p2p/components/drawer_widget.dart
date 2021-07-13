import 'package:flutter/material.dart';

Widget drawerWidget(){
  return Drawer(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text('Filter'),
            ),
          ],
        ),
      ),
    ),
  );
}