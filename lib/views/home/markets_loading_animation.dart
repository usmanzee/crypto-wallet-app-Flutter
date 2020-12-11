import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MarketsLoadingAnimation extends StatelessWidget {
  final BuildContext context;
  MarketsLoadingAnimation({this.context});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (ctx, i) {
            return loadingGainers(ctx);
          },
        ),
      ),
    );
  }

  Widget loadingGainers(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 17.0),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(ctx).hintColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Theme.of(ctx).hintColor,
                ),
                height: 20.0,
                width: 70.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Theme.of(ctx).hintColor,
                ),
                height: 20.0,
                width: 115.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                color: Theme.of(ctx).hintColor,
                width: 80.0,
                height: 35.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
