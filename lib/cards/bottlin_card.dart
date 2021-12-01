import 'package:cokefactory/cards/rate_card.dart';
import 'package:cokefactory/restAPI/rest_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottlingCard extends StatelessWidget {
  const BottlingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pressure = 0;
    bool status = false;
    return BlocBuilder<RestApiCubit, RestApiState>(
      builder: (context, state) {
        if (state is DataUpdatedState) {
          pressure = state.data.bottlingPressure;
          status = state.data.bottlingStatus;
        }
        return Container(
          width: 400,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Bottling Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:10.0),
                        StatusWidget(status: status),
                        getStatusIndicator("Pump Pressure: $pressure bar",status),
                      ],
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     ElevatedButton(
                    //         onPressed: () {
                    //
                    //         }, child: Text("Api Test")),
                    //     ElevatedButton(onPressed: () {}, child: Text("Stop Production"))
                    //   ],
                    // )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget getStatusIndicator(String title, bool status) {
  return Row(
    children: [
      Icon(status ? Icons.check : Icons.error),
      SizedBox(
        width: 10,
      ),
      Text(title)
    ],
  );
}
