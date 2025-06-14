import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final dynamic item;

  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: myWidth * 0.0000001,
        vertical: myHeight * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: myHeight * 0.015,
            horizontal: myWidth * 0.0000001,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: myHeight * 0.06,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: myWidth * 0.02),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.id,
                      style: TextStyle(
                        fontSize: myHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: myHeight * 0.005),
                    Text(
                      '0.4 ${item.symbol}',
                      style: TextStyle(
                        fontSize: myHeight * 0.018,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: myHeight * 0.05,
                  child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 2.0,
                    lineColor: item.marketCapChangePercentage24H >= 0
                        ? Colors.green
                        : Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.7],
                      colors: item.marketCapChangePercentage24H >= 0
                          ? [Colors.green, Colors.green.shade100]
                          : [Colors.red, Colors.red.shade100],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${item.currentPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: myHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: myHeight * 0.005),
                    Row(
                      children: [
                        Text(
                          item.priceChange24H.toString().contains('-')
                              ? '-\$${item.priceChange24H.abs().toStringAsFixed(2)}'
                              : '\$${item.priceChange24H.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: myHeight * 0.016,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: myWidth * 0.02),
                        Text(
                          '${item.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: myHeight * 0.016,
                            color: item.marketCapChangePercentage24H >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}