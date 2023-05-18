import 'package:flutter/material.dart';
import 'package:ride_along/constants/colors.dart';

class AutoCompleteTextField extends StatefulWidget {
  final List<String> options;
  final Function(String)? onSelected;

  AutoCompleteTextField({required this.options, this.onSelected});

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _textEditingController.selection = TextSelection(
            baseOffset: 0, extentOffset: _textEditingController.text.length);
      }
    });
  }

  void _onChanged(String value) {
    setState(() {
      _suggestions = widget.options
          .where(
              (option) => option.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _textEditingController.text = suggestion;
      _suggestions = [];
    });
    if (widget.onSelected != null) {
      widget.onSelected!(suggestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          onChanged: _onChanged,
          decoration: InputDecoration(
            labelText: 'Enter text',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        if (_suggestions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: kTextColorLight,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  onTap: () => _onSuggestionSelected(_suggestions[index]),
                );
              },
            ),
          ),
      ],
    );
  }
}
