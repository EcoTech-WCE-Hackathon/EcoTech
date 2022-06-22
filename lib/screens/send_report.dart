import 'dart:convert';
import 'dart:io';

import 'package:ecotech/components/button.dart';
import 'package:ecotech/consts/constants.dart';
import 'package:ecotech/screens/verdict_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SendReport extends StatefulWidget {
  const SendReport({Key? key, required this.imageFile, required this.location})
      : super(key: key);

  final File imageFile;
  final String location;

  @override
  State<SendReport> createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  bool typeValidate = false;
  TextEditingController typeController = TextEditingController();

  Future<void> sendData(File img, String location, String type) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Text(
                  "Location: ${widget.location}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Icon(
                          Icons.mail,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          style: GoogleFonts.montserrat(),
                          controller: typeController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Waste Type',
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.black,
                            ),
                            errorText:
                                typeValidate ? 'Field can\'t be empty' : null,
                            errorStyle: GoogleFonts.montserrat(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  text: "Send Report",
                  hasIcon: true,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var uri = Uri.parse("$BASE_URL/mobile/report");

                    var request = http.MultipartRequest("POST", uri);
                    request.files.add(
                      http.MultipartFile.fromBytes(
                        "image",
                        widget.imageFile.readAsBytesSync(),
                        filename: "image.jpg",
                      ),
                    );
                    request.fields["location"] = widget.location;
                    request.fields["wasteType"] = typeController.text;

                    request.headers.addAll({
                      "Authorization":
                          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjU2MzMwNTkwLCJpYXQiOjE2NTU4OTg1OTAsImp0aSI6IjIxNDg3NzZlZDE2YjRjMTk5M2VhODQzYjg1ZTJkZmZlIiwidXNlcl9pZCI6Nn0.gGOV6XnqtXw8iAdzlOyHz0lye7PN3FmrcSHrEk0v1Qk"
                    });

                    var response = await request.send();
                    response.stream.transform(utf8.decoder).listen(
                      (value) {
                        Map responseJson = json.decode(value);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerdictScreen(
                                verdict: responseJson["data"]
                                    ["approval_status"]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
