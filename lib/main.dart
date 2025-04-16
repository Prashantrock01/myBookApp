import 'package:flutter/material.dart';
import 'package:my_books_app/viewmodels/mybook_viewmodel.dart';
import 'package:my_books_app/views/mybook_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyBooksApp());
}

class MyBooksApp extends StatelessWidget {
  const MyBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MYBooks',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BookListScreen(),
      ),
    );
  }
}
