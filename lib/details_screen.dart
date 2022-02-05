import 'package:db_qr_code/intances.dart';
import 'package:db_qr_code/views/liteQr.dart';
import 'package:db_qr_code/qr_code.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetailsScreen extends StatefulWidget {
  final MyQrCode qrCode;
  final Function callback;
  const DetailsScreen({Key? key, required this.qrCode, required this.callback})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String dropdownValue = "PCR";
  bool isSwitched = false;
  DateTime currentDate = DateTime.now();
  String? errorOthers;
  TextEditingController otherController = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late String token;
  late String androidId;
  late String notifToken;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) => token=value!);
    ajouter();
  }
  Future ajouter() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    androidId = androidInfo.androidId;
    notifToken="eArrxHI5SYmxYJ8Am7dFJS:APA91bEMkCDnfT5Ma-EqCW-emaulS4ZS7WwMfC147Rg4zEBF77gWrM9V5uEtntn1III9kWcKO0kol18g4vAcs3nRwDl_cheV7lyYN3bS9bJECb1I7W5-g83Nsriv6Ng44V5wQjS43MrY";
  }
  Future<void> _sendData(token) async {
    var client = http.Client();
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      var uuid = Uuid();
      udid = uuid.v1();
    }
    try {
      var response = await client.post(
          Uri.parse('http://192.168.1.11:8000/api/v1/positif'),

          body: {'token': token, 'udid': udid,'notifToken':notifToken});
      var decodedResponse =
      convert.jsonDecode(convert.utf8.decode(response.bodyBytes)) as Map;
      var key = decodedResponse['key'] as String;

    } finally {
      client.close();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Détails"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    onChanged: (date) {}, onConfirm: (date) {
                      setState(() {
                        currentDate = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.fr);
              },
              child: Text(
                formatDate(currentDate),
                style: const TextStyle(color: Colors.blue),
              )),
          Container(
            child: widget.qrCode.type != 'qrCode'
                ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Text(widget.qrCode.type.toString()),
                title: Text(widget.qrCode.content.toString()),
              ),
            )
                : QrImage(
              data: widget.qrCode.content.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 3,
                color: Theme.of(context).primaryColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['PCR', 'Pass Covid', 'Autorisation', 'Autre']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          dropdownValue == 'Autre'
              ? Padding(
            padding:
            const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: TextField(
              decoration: InputDecoration(errorText: errorOthers),
              controller: otherController,
            ),
          )
              : const SizedBox(
            width: 0.0,
          ),
          dropdownValue == 'PCR'
              ? Padding(
            padding:
            const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: Row(
              children: [
                const Text("Covid positive"),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          )
              : const SizedBox(
            width: 0.0,
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseMessaging.instance.getToken().then((value) => {_sendData(value)});

                if (dropdownValue == 'Autre') {
                  if (otherController.value.text.toString().isEmpty) {
                    setState(() {
                      errorOthers = "Vous devez choisir un type!";
                    });
                    return;
                  }
                  errorOthers = null;
                  widget.qrCode.type = otherController.value.text.toString();
                } else {
                  widget.qrCode.type = dropdownValue;
                }
                widget.qrCode.pcr = isSwitched;
                widget.qrCode.date = currentDate;
                myData.box.put(widget.qrCode);
                widget.callback(widget.qrCode);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const MyHomePage(title: "Qr Code Scanner")),
                );
              },
              child: const Text("Validate"))
        ],
      ),
    );
  }
}