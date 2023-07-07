import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WorldTimeApp());
}

class WorldTimeApp extends StatefulWidget {
  @override
  _WorldTimeAppState createState() => _WorldTimeAppState();
}

class _WorldTimeAppState extends State<WorldTimeApp> {
  String selectedLocation = 'Africa/Cairo'; // Default selected location
  String time = '';

  void getTime() async {
    Uri apiUrl =
        Uri.parse('http://worldtimeapi.org/api/timezone/${selectedLocation}');
    http.Response response = await http.get(apiUrl);
    Map data = jsonDecode(response.body);
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));

    setState(() {
      time = now.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('World Time App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DropdownButtonFormField(
                value: selectedLocation,
                items: const [
                  DropdownMenuItem(
                      value: 'Africa/Cairo', child: Text('Africa-Cairo')),
                  DropdownMenuItem(
                    value: 'Europe/London',
                    child: Text('Europe - London'),
                  ),
                  DropdownMenuItem(
                    value: 'America/New_York',
                    child: Text('America - New York'),
                  ),
                  DropdownMenuItem(
                    value: 'Asia/Tokyo',
                    child: Text('Asia - Tokyo'),
                  ),
                  DropdownMenuItem(
                    value: 'Australia/Sydney',
                    child: Text('Australia - Sydney'),
                  ),
                  DropdownMenuItem(
                    value: 'Europe/Paris',
                    child: Text('Europe - Paris'),
                  ),
                  DropdownMenuItem(
                    value: 'Pacific/Auckland',
                    child: Text('Pacific - Auckland'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value.toString();
                  });
                },
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                  onPressed: () {
                    getTime();
                  },
                  child: const Text('Get Time')),
              const Text(
                'Current Time:',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 10.0),
              Text(time, style: const TextStyle(fontSize: 30.0)),
            ],
          ),
        ),
      ),
    );
  }
}
