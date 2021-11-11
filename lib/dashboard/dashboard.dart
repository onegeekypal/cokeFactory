import 'package:cokefactory/cards/bottlin_card.dart';
import 'package:cokefactory/cards/rate_card.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(maxWidth: 500),child: ListView(children: [SizedBox(height: 20,),RateCard(),SizedBox(height: 20,),BottlingCard(),]));
  }
}
