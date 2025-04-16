import 'package:flutter/material.dart';
import 'package:my_books_app/viewmodels/mybook_viewmodel.dart';
import 'package:my_books_app/views/mybook_details_screen.dart';
import 'package:my_books_app/views/mybook_favourite_screen.dart';
import 'package:provider/provider.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<BookViewModel>(context, listen: false);
    vm.fetchBooks();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        vm.fetchBooks(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookViewModel>(
      builder: (context, vm, _) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'MYBooks',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FavouriteScreen()),
                );
              },
            ),
          ],
        ),
        body: vm.books.isEmpty && vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _controller,
                itemCount: vm.books.length + 1,
                itemBuilder: (context, index) {
                  if (index == vm.books.length) {
                    return vm.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
                  }

                  final book = vm.books[index];

                  return ListTile(
                    leading: Image.network(
                      book.coverUrl,
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Author: ${book.authorName}"),
                            if (book.coverId != null)
                          Text("Cover ID: ${book.coverId}"),
                          if (book.key.isNotEmpty)
                          Text("Key: ${book.key}", style: const TextStyle(color: Colors.grey)),
                          if (book.description != null && book.description!.isNotEmpty)
                          Text("Description: ${book.description}", maxLines: 2, overflow: TextOverflow.ellipsis),
                           if (book.firstPublishYear != null)
                          Text("First Published: ${book.firstPublishYear}"),
                        if (book.subjects != null && book.subjects!.isNotEmpty)
                          Text("Subjects: ${book.subjects!.take(3).join(', ')}"),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(
                        vm.isFavourite(book)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: vm.isFavourite(book) ? Colors.red : null,
                      ),
                      onPressed: () => vm.toggleFavourite(book),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
