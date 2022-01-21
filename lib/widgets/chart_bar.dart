import 'package:flutter/material.dart';

class Chart_bars extends StatelessWidget {
  final String label;
  final double amount;
  final double spendpercent;
  const Chart_bars(this.label, this.amount, this.spendpercent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: [
          Container(
            height: constrains.maxHeight * 0.1,
            child: FittedBox(
              child: Text('\$${amount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constrains.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendpercent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(height: constrains.maxHeight * 0.12, child: Text(label))
        ],
      );
    });
  }
}
