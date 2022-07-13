import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations{
  DemoLocalizations(this.locale);
  final Locale locale;
  static DemoLocalizations of(BuildContext context){
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  // Map<String, String> _localizedValues;
  //
  // Future load() async{
  //   String jsonStringValues =
  //   await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
  //
  //  Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
  //
  //  _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  //
  // }

   
}