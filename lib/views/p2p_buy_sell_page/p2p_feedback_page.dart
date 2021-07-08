import 'package:flutter/material.dart';

class P2pFeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backwardsCompatibility: false,
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 220.0,
            floating: true,
            titleSpacing: 0,
            actions: [
              Container(),
            ],
            title: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                  Row(
                    children: [
                      Text('asasasasasas'),
                    ],
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(collapseMode: CollapseMode.none,
              titlePadding: EdgeInsets.only(
                top: 100,
              ),
              title: Text('123'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                200,
                (index) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('text $index'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
