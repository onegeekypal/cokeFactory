
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RateCard extends StatefulWidget {
  const RateCard({Key? key}) : super(key: key);

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> with TickerProviderStateMixin{
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Main Status",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Lottie.asset('assets/animations/8758-bottling-factory.json',controller: _controller,onLoaded: (composition){_controller..duration = composition.duration..repeat();}),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:[Row(children: [Icon(Icons.check),SizedBox(width: 10,),Text("Status: OK")],),Text("Current Production Rate: 50/min"),],),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [ElevatedButton(onPressed: (){_controller.repeat(); setState(() {

              });}, child: Text("Start Production")),ElevatedButton(onPressed: (){_controller.stop(canceled: false);}, child: Text("Stop Production")),],)
            ],
          ),
        ),
      );
  }
}




