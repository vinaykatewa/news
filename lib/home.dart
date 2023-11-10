import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=0285b3005ba34aa8aaed0c06ae97ff8c'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        articles = data['articles'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 167, 190),
        title: const Text('News App'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Container(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(
                article['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(article['description'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
