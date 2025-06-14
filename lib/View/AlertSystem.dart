import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(CryptoAlertApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Background task logic here
    return Future.value(true);
  });
}

class CryptoAlertApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Alert System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      home: AlertPage(),
    );
  }
}

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final List<String> availableCurrencies = [
    "BTC-USD",
    "ETH-USD",
    "SOL-USD",
    "XRP-USD",
    "USDT-USD",
    "ADA-USD",
    "DOGE-USD",
    "DOT-USD",
    "BNB-USD",
    "LTC-USD",
    "SHIB-USD"
  ];

  String? selectedCurrency;
  double? thresholdPercentage;
  bool isMonitoring = false;
  double? previousPrice;
  bool isLoading = false;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    initializeLocalNotifications();
  }

  void initializeFirebaseMessaging() async {
    await messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(
          message.notification!.title ?? 'Notification',
          message.notification!.body ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  void initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    localNotifications.initialize(initializationSettings);
  }

  Future<void> saveNotificationToFirestore(String title, String body) async {
    try {
      await firestore.collection('notifications').add({
        'title': title,
        'body': body,
        'timestamp': FieldValue.serverTimestamp(), // Timestamp for sorting
      });
      print('Notification saved successfully');
    } catch (e) {
      print('Failed to save notification: $e');
    }
  }

  Future<void> showLocalNotification(String title, String body) async {
    // Save the notification to Firestore
    await saveNotificationToFirestore(title, body);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'crypto_alerts',
      'Crypto Alerts',
      channelDescription: 'Alerts for significant cryptocurrency price changes',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotifications.show(0, title, body, platformChannelSpecifics);
  }

  Future<void> fetchCurrencyPrice() async {
    if (selectedCurrency == null || thresholdPercentage == null) return;

    final url = Uri.parse('https://api.coinbase.com/v2/prices/$selectedCurrency/spot');
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(url);
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentPrice = double.parse(data['data']['amount']);

        if (previousPrice != null) {
          final change = ((currentPrice - previousPrice!) / previousPrice!) * 100;
          if (change.abs() >= thresholdPercentage!) {
            showLocalNotification(
              'Price Alert: $selectedCurrency',
              'Price changed by ${change.toStringAsFixed(2)}% to \$${currentPrice.toStringAsFixed(2)}.',
            );
          }
        }

        setState(() {
          previousPrice = currentPrice;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch price for $selectedCurrency')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching price: $e')),
      );
    }
  }

  void startMonitoring() {
    if (selectedCurrency == null || thresholdPercentage == null || thresholdPercentage! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a valid currency and enter a positive threshold.')),
      );
      return;
    }

    setState(() {
      isMonitoring = true;
    });

    Future.doWhile(() async {
      if (!isMonitoring) return false;
      await fetchCurrencyPrice();
      await Future.delayed(Duration(seconds: 5));
      return true;
    });
  }

  void stopMonitoring() {
    setState(() {
      isMonitoring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Alert System', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Back arrow removed
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF7B4397)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Your Alerts',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Currency',
                    border: OutlineInputBorder(),
                  ),
                  items: availableCurrencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                      previousPrice = null;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Threshold Percentage',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      thresholdPercentage = double.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: isMonitoring ? null : startMonitoring,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A90E2),
                      ),
                      child: Text('Start Monitoring'),
                    ),
                    ElevatedButton(
                      onPressed: isMonitoring ? stopMonitoring : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7B4397),
                      ),
                      child: Text('Stop Monitoring'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                if (isLoading) Center(child: CircularProgressIndicator()),
                if (selectedCurrency != null && previousPrice != null)
                  Card(
                    color: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Monitoring:',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                          SizedBox(height: 8),
                          Text('Currency: $selectedCurrency'),
                          Text('Last Price: \$${previousPrice!.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
