import 'package:flutter/material.dart';

import "package:flutter_application_73/item.dart";

Future<List<Item>> fetchData() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    Item(title: 'Item 1', description: 'Description 1'),
    Item(title: 'Item 2', description: 'Description 2'),
    Item(title: 'Item 3', description: 'Description 3'),
  ];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulated Data Fetching'),
      ),
      body: Center(
        child: FutureBuilder<List<Item>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].title),
                    subtitle: Text(items[index].description),
                  );
                },
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulated Data Fetching',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
