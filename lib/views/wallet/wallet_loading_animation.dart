import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WalletLoadingAnimation extends StatelessWidget {
  final BuildContext context;
  WalletLoadingAnimation({this.context});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (ctx, i) {
          return loadingData(ctx);
        },
      ),
    );
  }

  Widget loadingData(BuildContext context) {
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
                    backgroundColor: Theme.of(context)
                        .hintColor
                        .withOpacity(0.2)
                        .withOpacity(0.2),
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
                              color: Theme.of(context)
                                  .hintColor
                                  .withOpacity(0.2)
                                  .withOpacity(0.2),
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
                            color: Theme.of(context)
                                .hintColor
                                .withOpacity(0.2)
                                .withOpacity(0.2),
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
                color: Theme.of(context)
                    .hintColor
                    .withOpacity(0.2)
                    .withOpacity(0.2),
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

class ExtimatedPriceLoadingAnimation extends StatelessWidget {
  final BuildContext context;
  ExtimatedPriceLoadingAnimation({this.context});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                height: 15.0,
                width: 200.0,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                height: 15.0,
                width: 200.0,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                height: 15.0,
                width: 100.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    height: 15.0,
                    width: 140.0,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    height: 15.0,
                    width: 140.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
