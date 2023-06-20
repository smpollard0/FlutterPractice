import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recipe App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> recipes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipes = getRecipes();
    // fetch our recipies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(future: recipes, builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }
            if (snapshot.hasData){
              return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Uri url = Uri.parse(snapshot.data![index]["url"]);
                      _launchUrl(url);
                    },
                    child: Card(
                        child: Column(children: [
                  ListTile(title: Text(snapshot.data![index]["title"])),
                  Image.network("https://i.kym-cdn.com/entries/icons/original/000/025/382/Screen_Shot_2018-02-06_at_3.37.14_PM.png"),
                  ])));
                },
              );
            }
            return const Text("Shouldn't get here");
        }
      },),
    );
  }
  
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)){
      if (kDebugMode) {
        print("Could not launch $url");
      }
    }
  }

  Future<List> getRecipes() async{
    var url =
      Uri.https('rest.bryancdixon.com');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (kDebugMode) {
        print(jsonResponse["recipes"][0]);
      }
      return jsonResponse["recipes"];
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return List.empty();
  }
}
