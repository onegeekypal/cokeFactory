import 'package:cokefactory/bloc/login_cubit.dart';
import 'package:cokefactory/restAPI/rest_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class RateCard extends StatefulWidget {
  const RateCard({Key? key}) : super(key: key);

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> with TickerProviderStateMixin {
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
    double rate = 0;
    bool status = false;
    return BlocBuilder<RestApiCubit, RestApiState>(
      builder: (context, state) {
        if (state is DataUpdatedState) {
          rate = state.data.rate;
          status = state.data.rateStatus;
          if (status) {

          } else {

          }
        }
        bool isAdmin = userType == "Admin";

        return Container(
          width: 400,
          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Main Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Lottie.asset('assets/animations/8758-bottling-factory.json', controller: _controller, onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..repeat();
                }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatusWidget(
                      status: status,
                    ),
                    Text("Current Production Rate: $rate/min"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (isAdmin) {
                          _controller.repeat();
                          BlocProvider.of<RestApiCubit>(context).startMainStatus();
                        }
                      },
                      child: Text("Start Production"),
                      style: ElevatedButton.styleFrom(primary: isAdmin ? Colors.blue : Colors.grey),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (isAdmin) {
                            _controller.stop(canceled: false);
                            BlocProvider.of<RestApiCubit>(context).stopMainStatus();
                          }
                        },
                        child: Text("Stop Production"),
                        style: ElevatedButton.styleFrom(primary: isAdmin ? Colors.blue : Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatusWidget extends StatelessWidget {
  final bool status;
  const StatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(status ? Icons.check : Icons.error),
        SizedBox(
          width: 10,
        ),
        Text(status ? "Status: OK" : "Status : Stopped")
      ],
    );
  }
}
