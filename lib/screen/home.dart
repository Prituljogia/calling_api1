import 'dart:async';
import 'package:calling_api1/model/user.dart';
import 'package:calling_api1/services/user_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'internet.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  late StreamSubscription internetConnected;
  late StreamSubscription connected;
  List<User> users = [];

  @override
  void initState() {

    super.initState();
    fetchusers();
    // ON CHANGED BETWEEN MOBILE AND WIFI
    connected = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        this.result = result;
      });
    });
    //ON INTERNET STATUS CHANGE
    internetConnected =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  void dispose() {
    internetConnected.cancel();
    connected.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random userapi"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                    child: Image.network(user.picture.thumbnail)),
                title: Text(user.fullName),
                subtitle: Text(user.location.country),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          hasInternet = await InternetConnectionChecker().hasConnection;
          result = await Connectivity().checkConnectivity();
          final color = hasInternet ? Colors.green : Colors.red;
          final text = hasInternet ? "Internet" : "No Internet";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(text,style: TextStyle(color: color),),
          ));
          fetchusers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<void> fetchusers() async {
    final response = await UserApi.fetchusers();
    setState(() {
      users = response;
    });
  }


}
