import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  double temp = 0;

  @override
  void initState() {
    super.initState();
    // getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: const [
          InkWell(
            child: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final data = snapshot.data!;
            final currentTemp = data['list'][0]['main']['temp'];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Icon(
                                  Icons.cloud,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Rain',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Align(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      'Weather Forecast',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyCard(
                          time: '09:00',
                          hourIcon: Icons.cloud,
                          temp: 301.17,
                        ),
                        HourlyCard(
                          time: '12:00',
                          hourIcon: Icons.water,
                          temp: 297.22,
                        ),
                        HourlyCard(
                          time: '15:00',
                          hourIcon: Icons.sunny,
                          temp: 300,
                        ),
                        HourlyCard(
                          time: '18:00',
                          hourIcon: Icons.cloud,
                          temp: 322.7,
                        ),
                        HourlyCard(
                          time: '21:00',
                          hourIcon: Icons.foggy,
                          temp: 300.23,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Align(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        addicon: Icons.air,
                        condition: 'Humidity',
                        temp: '94',
                      ),
                      AdditionalInfo(
                        addicon: Icons.water_drop,
                        condition: 'Rain',
                        temp: '97',
                      ),
                      AdditionalInfo(
                        addicon: Icons.water,
                        condition: 'Hazy',
                        temp: '84',
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
