import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;


var stringResponse = '';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _selectedtrain;

  Future<List<Map>> fetchItems() async{
    List<Map> items = [];

    http.Response response = await http.get(Uri.parse('https://irctc1.p.rapidapi.com/api/v1/searchStation'));

    if (response.statusCode == 200)
    {
      items = jsonDecode(response.body);
    }
    print(items);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    fetchItems();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: Colors.black87,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.blueAccent,
                height: 4.0,
              ),
            ),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.menu,color: Colors.white,),
            ),
            title: Text('Bookings...',style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,))
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.7,
                    child: ListView(
                      children: [
                        Align(
                          alignment: Alignment(-1.0,-1.0),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Select From Station",style: TextStyle(fontSize: 16,color: Colors.white),),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0,10),
                                ),
                              ]
                          ),
                          child: SearchField(
                            suggestions: ["ch","ind"].map((e) =>
                                SearchFieldListItem(e)).toList(),
                            hint: 'Search Departure Station',
                            searchInputDecoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey.shade200,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue.withOpacity(0.8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            itemHeight: 50,
                            maxSuggestionsInViewPort: 6,
                            suggestionsDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onSuggestionTap: (value) {
                              setState(() {
                                _selectedtrain = value.toString() ??'';
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Select To Station",style: TextStyle(fontSize: 16,color: Colors.white),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0,10),
                                ),
                              ]
                          ),
                          child: SearchField(
                            suggestions: ["ch","ind"].map((e) =>
                                SearchFieldListItem(e)).toList(),
                            hint: 'Search Arrival Station',
                            searchInputDecoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey.shade200,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue.withOpacity(0.8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            itemHeight: 50,
                            maxSuggestionsInViewPort: 6,
                            suggestionsDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onSuggestionTap: (value) {
                              setState(() {
                                _selectedtrain = value.toString() ??'';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




















