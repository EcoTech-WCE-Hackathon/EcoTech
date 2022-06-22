import 'dart:io';

import 'package:ecotech/components/button.dart';
import 'package:ecotech/helper/colors.dart';
import 'package:ecotech/screens/upload_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<_ChartData> data;

  @override
  void initState() {
    data = [
      _ChartData('MON', 12),
      _ChartData('TUE', 15),
      _ChartData('WED', 30),
      _ChartData('THU', 6.4),
      _ChartData('FRI', 14),
      _ChartData('SAT', 7),
      _ChartData('SUN', 18),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    late File _image;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hey there,",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.brandColor,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "./images/ecotech_white.png",
                          height: 30,
                        ),
                        Text(
                          "150.38",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "EcoTokens earned",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(
                            16,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "32 kg",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Waste Recycled",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(
                            16,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "4 kg",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Toxins Disposed",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(
                            16,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "8",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Successful Reports",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                enableAxisAnimation: true,
                series: <ChartSeries<_ChartData, String>>[
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    cardinalSplineTension: 1,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.brandColor, Color(0xffa2f5f5)],
                      stops: [0.6, 1.0],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                onPressed: () async {
                  XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 5,
                  );
                  setState(() {
                    _image = File(image!.path);
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadImageScreen(
                        imageFile: _image,
                      ),
                    ),
                  );
                },
                hasIcon: true,
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                text: "Report Waste",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
