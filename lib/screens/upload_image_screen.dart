import 'dart:convert';
import 'dart:io';

import 'package:ecotech/components/button.dart';
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:http/http.dart" as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key, required this.imageFile}) : super(key: key);

  final File imageFile;

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                child: Image.file(
                  widget.imageFile,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                text: "Fetch Location",
                hasIcon: true,
                icon: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                onPressed: () async {
                  LocationPermission permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied) {
                    permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied) {
                      print("Permission denied!!!");
                    }
                  }
                  Position position =
                      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  var headers = {
                    "accept": "application/json",
                  };
                  http.Response response = await http.get(
                    Uri.parse(
                        "https://apis.mappls.com/advancedmaps/v1/02b39aa0036154f05f2d68abed7c23d1/rev_geocode?lat=${position.latitude}&lng=${position.longitude}&region=IND&lang=eng"),
                    headers: headers,
                  );
                  Map responseJson = json.decode(response.body);

                  print(responseJson["results"][0]["formatted_address"]);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
