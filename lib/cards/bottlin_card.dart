import 'package:flutter/material.dart';

class BottlingCard extends StatelessWidget {
  const BottlingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStatusIndicator("Pump Status"),
                getStatusIndicator("Pump Pressure: 15 bar"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: Text("Start Production")),
                ElevatedButton(onPressed: () {}, child: Text("Stop Production"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget getStatusIndicator(String title) {
  return Row(
    children: [
      Icon(Icons.check),
      SizedBox(
        width: 10,
      ),
      Text(title)
    ],
  );
}
