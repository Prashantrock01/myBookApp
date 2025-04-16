import 'package:flutter/material.dart';
import 'package:my_books_app/viewmodels/mybook_viewmodel.dart';
import 'package:my_books_app/views/mybook_details_screen.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: vm.favourites.isEmpty
          ? const Center(
              child: Text(
                'No favourites yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.favourites.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final book = vm.favourites[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      book.coverUrl,
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 50,
                        height: 75,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
                        Text(
                          "Description: ${book.description}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      if (book.firstPublishYear != null)
                        Text("Published: ${book.firstPublishYear}"),
                      if (book.subjects != null && book.subjects!.isNotEmpty)
                        Text("Subjects: ${book.subjects!.take(3).join(', ')}"),
                    ],
                  ),
                  trailing: IconButton(
                  //  icon: const Icon(Icons.remove_circle, color: Colors.red),
                    icon: const Icon(Icons.delete_forever_outlined,color: Colors.red),
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
    );
  }
}