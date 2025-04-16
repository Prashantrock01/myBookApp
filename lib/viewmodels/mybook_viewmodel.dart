import 'package:flutter/material.dart';
import 'package:my_books_app/model/mybook_model.dart';
import 'package:my_books_app/service/mybook_service.dart';

class BookViewModel extends ChangeNotifier {
  final List<Book> _books = [];
  final List<Book> _favourites = [];

  bool isLoading = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 15;

  List<Book> get books => _books;
  List<Book> get favourites => _favourites;

  Future<void> fetchBooks({bool loadMore = false}) async {
    if (isLoading || !_hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final newBooks = await ApiService.fetchBooks(offset: _offset);
      if (loadMore) {
        _books.addAll(newBooks);
      } else {
        _books.clear();
        _books.addAll(newBooks);
      }
      _offset += _limit;
      _hasMore = newBooks.length == _limit;
    } catch (e) {
      debugPrint('Error fetching books: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavourite(Book book) {
    if (_favourites.contains(book)) {
      _favourites.remove(book);
    } else {
      _favourites.add(book);
    }
    notifyListeners();
  }

  bool isFavourite(Book book) => _favourites.contains(book);
}
