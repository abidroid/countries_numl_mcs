import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'country.dart';

class CountryDetailScreen extends StatelessWidget {

  final Country country;


  const CountryDetailScreen({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Details'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Hero(
                tag: country.iso2,
                child: SvgPicture.network(country.flag,fit: BoxFit.fill,)),
          ),

          Text(country.name, style: TextStyle(fontSize: 30),),
          Text(country.iso2, style: TextStyle(fontSize: 30),),
          Text(country.iso3, style: TextStyle(fontSize: 30),),

        ],
      ),
    );
  }
}
