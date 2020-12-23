import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WalletLoadingAnimation extends StatelessWidget {
  final BuildContext context;
  WalletLoadingAnimation({this.context});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (ctx, i) {
            return loadingData(ctx);
          },
        ),
      ),
    );
  }

  Widget loadingData(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 17.0, right: 8.0),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(ctx).hintColor,
                    radius: 13.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 15.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Theme.of(ctx).hintColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 12.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: Theme.of(ctx).hintColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                color: Theme.of(ctx).hintColor,
                width: 80.0,
                height: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
