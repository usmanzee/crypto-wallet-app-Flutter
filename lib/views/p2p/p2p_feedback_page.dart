import 'package:flutter/material.dart';

class P2pFeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Qwqwqwqwqw'),
            // primary: true,
            pinned: true,
            // floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.purple,
              ),
              title: Text('jijhii'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text("List tile $index"),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
