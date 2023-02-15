import 'dart:async';
import 'package:calling_api1/screen/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class Internet extends StatefulWidget {
  const Internet({Key? key}) : super(key: key);

  @override
  State<Internet> createState() => _InternetState();
}

class _InternetState extends State<Internet> {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  late StreamSubscription internetConnected;
  late StreamSubscription connected;

  @override
  void initState() {
    super.initState();
    // ON CHANGED BETWEEN MOBILE AND WIFI
    connected = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        this.result = result;
      });
    });
    //ON INTERNET STATUS CHANGE
    internetConnected = InternetConnectionChecker().onStatusChange.listen((status) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //button
            ElevatedButton(
              onPressed: () async {
                hasInternet = await InternetConnectionChecker().hasConnection;
                result = await Connectivity().checkConnectivity();
                final color = hasInternet ? Colors.green : Colors.red;
                final text = hasInternet ? "Internet" : "No Internet";
                // MOBILE
                if (result == ConnectivityResult.mobile) {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()));
                  /*showSimpleNotification(
                    Text(
                      "$text : Mobile",
                    ),
                    background: color,
                  );*/
                }
                //WIFI
                else if (result == ConnectivityResult.wifi) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()));
                 /* showSimpleNotification(
                    Text(
                      "$text : Wifi",
                    ),
                    background: color,
                  );*/

                  // NOT INTERNET CONNECTED
                } else {
                  showSimpleNotification(
                    Text(
                      text,
                    ),
                    background: color,
                  );
                }
              },
              child: const Text("Check Internet Status"),
            ),
            const SizedBox(
              height: 20,),
            // INTERNET STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hasInternet
                    ? const Icon(Icons.four_g_mobiledata_outlined)
                    : const Icon(Icons.dangerous),
                Text(hasInternet ? "Internet Connected" : "No Internet"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //MOBILE
            if (result == ConnectivityResult.mobile)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.mobile_friendly),
                  Text("Mobile Internet is Connected"),
                ],
              ),
            // WIFI
            if (result == ConnectivityResult.wifi)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wifi),
                  Text("Wifi is Connected"),
                ],
              ),
            // NO DEVICE CONNECTED
            if (result == ConnectivityResult.none)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.dangerous),
                  Text("No Internet Connected"),
                ],
              )
          ],
        ),
      ),
    );
  }
}