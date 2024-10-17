import 'package:alkamel/src/features/search/presentation/components/search_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchField(),
      ),
      body: Container(),
    );
  }
}
