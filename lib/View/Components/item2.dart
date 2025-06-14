import 'package:firebases/View/selectCoin.dart';
import 'package:flutter/material.dart';

class Item2 extends StatelessWidget {
  final dynamic item;
  Item2({this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: myWidth * 0.03,
        vertical: myHeight * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectCoin(selectItem: item),
            ),
          );
        },
        child: Container(
          width: myWidth * 0.4, // Adjusting width for landscape and portrait
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: myHeight * 0.02,
              horizontal: myWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: myHeight * 0.05,
                  width: myHeight * 0.05,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: myHeight * 0.02),
                Text(
                  item.id,
                  style: TextStyle(
                    fontSize: myHeight * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: myHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.priceChange24H.toString().contains('-')
                            ? "-\$" +
                            item.priceChange24H
                                .abs()
                                .toStringAsFixed(2)
                            : "\$" + item.priceChange24H.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: myHeight * 0.018,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: myWidth * 0.02),
                    Text(
                      '${item.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: myHeight * 0.018,
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
        ),
      ),
    );
  }
}
