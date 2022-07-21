import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'shikayat_service.dart';
class SubAdminTypeAhead extends StatefulWidget {
  const SubAdminTypeAhead({Key? key}) : super(key: key);

  @override
  State<SubAdminTypeAhead> createState() => _SubAdminTypeAheadState();
}

class _SubAdminTypeAheadState extends State<SubAdminTypeAhead> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: const InputDecoration(
                labelText: 'अपनी शिकायत का विषय चुनें'
              ),
              controller: _typeAheadController
            ),
              onSuggestionSelected: (String suggestion){
              setState((){
                _selectedItem = suggestion;
              });
              Navigator.of(context).pop(suggestion);
              },
              itemBuilder: (context, String suggestion){
              return ListTile(
                title: Text(suggestion),
              );
              },
              suggestionsCallback: (pattern) {
              return ShikayatService.getSuggestions(pattern);
              },
            transitionBuilder: (context, suggestionBox, controller){
              return suggestionBox;
            },
            validator: (value)=>value!.isEmpty ? "कृपया अपनी शिकायत का विषय चुनें" : null
          ),
        ),
      ),
    );
  }
}
