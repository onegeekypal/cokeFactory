import 'dart:async';

import 'package:cokefactory/cards/bottlin_card.dart';
import 'package:cokefactory/cards/rate_card.dart';
import 'package:cokefactory/restAPI/rest_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late final TabController controller;
  int index = 0;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {
        index = controller.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds:3),(timer){
      BlocProvider.of<RestApiCubit>(context).fetchData();
    });
    return Scaffold(
      appBar: AppBar(title: Text("Hello"), bottom: TabBar(controller: controller, tabs: [Text("Dashboard"), Text("Events")])),
      body: TabBarView(
        controller: controller,
        children: [DashboardWidget(), EventsWidget()],
      ),
      floatingActionButton: index == 1
          ? FloatingActionButton(
              onPressed: () {
                BlocProvider.of<RestApiCubit>(context).clearEvents();
              },
              child: Icon(Icons.delete),
              backgroundColor: Colors.red,
            )
          : null,
    );
  }
}

class EventsWidget extends StatefulWidget {
  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestApiCubit, RestApiState>(
      builder: (context, state) {
        List<EventItem> events = BlocProvider.of<RestApiCubit>(context).events;
        return events.isEmpty
            ? Center(child: Text("No events"))
            : ListView(
                children: events.reversed
                    .map((e) => Center(
                            child: Event(
                          eventData: e,
                        )))
                    .toList(),
              );
      },
    );
  }
}

class EventItem {
  final String status;
  final String messageTitle;
  final String message;

  EventItem({required this.status, required this.messageTitle, required this.message});
}

class Event extends StatelessWidget {
  final EventItem eventData;

  const Event({Key? key, required this.eventData}) : super(key: key);

  Icon _generateLeadingIcon() {
    double iconSize = 40.0;
    if (eventData.status == "Info")
      return Icon(
        Icons.info,
        color: Colors.blue,
        size: iconSize,
      );
    else if (eventData.status == "Warning")
      return Icon(
        Icons.warning,
        color: Colors.yellow,
        size: iconSize,
      );
    else if (eventData.status == "Critical")
      return Icon(
        Icons.dangerous,
        color: Colors.red,
        size: iconSize,
      );
    else
      return Icon(Icons.info);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(20.0)),
      constraints: BoxConstraints(maxWidth: 500),
      child: ListTile(
        leading: _generateLeadingIcon(),
        title: Text(eventData.messageTitle),
        subtitle: Text(eventData.message),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestApiCubit, RestApiState>(
      builder: (context, state) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: ListView(children: [
              SizedBox(
                height: 20,
              ),
              RateCard(),
              SizedBox(
                height: 20,
              ),
              BottlingCard(),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<RestApiCubit>(context).fetchData();
                  },
                  child: Text("Fetch data"))
            ]),
          ),
        );
      },
    );
  }
}
