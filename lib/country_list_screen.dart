import 'dart:convert';

import 'package:countries_numl_mcs/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'country.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  Future<List<Country>> getCountries() async {
    String url = 'https://countriesnow.space/api/v0.1/countries/flag/images';

    var response = await http.get(Uri.parse(url));

    List<Country> countries = [];
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      var countriesJsonList = jsonResponse['data'];

      for (var jsonCountry in countriesJsonList) {
        Country country = Country.fromMap(jsonCountry);
        countries.add(country);
      }
    }

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
      ),
      body: FutureBuilder<List<Country>>(
        future: getCountries(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Country> countries = snapshot.data as List<Country>;

            return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  Country country = countries[index];

                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return CountryDetailScreen(country: country);
                      }));
                    },
                    child: Card(

                      child: Row(
                        children: [
                          SizedBox(
                              width: 100,
                              height: 80,
                              child: Hero(
                                tag: country.iso2,
                                child: SvgPicture.network(
                                  country.flag,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          const SizedBox(width: 15,),
                          Text(country.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
