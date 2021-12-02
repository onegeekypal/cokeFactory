import 'package:bloc/bloc.dart';
import 'package:cokefactory/dashboard/dashboard.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'rest_api_state.dart';

class RestApiCubit extends Cubit<RestApiState> {
  late final http.Client client;
  List<EventItem> events = [];
  final Uri url = Uri.parse("http://localhost:5000");
  RestApiCubit() : super(RestApiInitial()) {
    client = http.Client();
  }

  void fetchData() async{
    var url = Uri.parse("http://localhost:5000/all");
    var response = await client.get(url);
    if (response.statusCode == 200){
      // print(response.body);
      var rate = jsonDecode(response.body)[2][0]['rate'];

      // print(bottlingPressure);
      var rateStatus = jsonDecode(response.body)[0][0]['status'];
      if(double.parse(rate) < 14.1 && rateStatus){
        addEvent(EventItem(status: "Warning", messageTitle: "Rate warning",message: "Slow production rate: ${double.parse(rate)}/min"));
      }
      var bottlingStatus = jsonDecode(response.body)[1][0]['status'];
      var bottlingPressure = jsonDecode(response.body)[3][0]['rate'];
      if (int.parse(bottlingPressure) <= 15 && int.parse(bottlingPressure) != 0){
        addEvent(EventItem(status: "Critical", messageTitle: "Pressure Error",message: "Low pressure: ${int.parse(bottlingPressure)} Bar"));
      }else if (int.parse(bottlingPressure) >= 19 && bottlingStatus){
        addEvent(EventItem(status: "Critical", messageTitle: "Pressure Error",message: "High pressure: ${int.parse(bottlingPressure)} Bar"));
      }
      emit(DataUpdatedState(data: DashboardData(rate: double.parse(rate),rateStatus: rateStatus,bottlingStatus: bottlingStatus,bottlingPressure: int.parse(bottlingPressure))));
    }

  }

  void startMainStatus() async{

    var url = Uri.parse("http://localhost:5000/main_status");
    var json = jsonEncode({"status" : "1"});
    var response = await client.post(url,headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },body: json);
    addEvent(EventItem(status: "Info", messageTitle: "Production state change",message: "Production started"));
    fetchData();
  }

  void stopMainStatus() async{

    var url = Uri.parse("http://localhost:5000/main_status");
    var json = jsonEncode({"status" : "0"});
    var response = await client.post(url,headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },body: json);
    addEvent(EventItem(status: "Info", messageTitle: "Production state change",message: "Production stopped"));
    fetchData();
  }

  void addEvent(EventItem newEvent){
    events.add(newEvent);
  }
  void clearEvents(){
    events = [];
    fetchData();
  }
}


class DashboardData {
  final double rate;
  final bool rateStatus;
  final bool bottlingStatus;
  final int bottlingPressure;
  DashboardData({required this.rate,required this.rateStatus,required this.bottlingStatus,required this.bottlingPressure});

  // factory DashboardData.fromJson(Map<String,dynamic> json){
  //   return DashboardData(rate: double.parse(json['rate']));
  // }

  // get getRate => this.rate;
}
