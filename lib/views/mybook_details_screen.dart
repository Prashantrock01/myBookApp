import 'package:flutter/material.dart';
import 'package:my_books_app/model/mybook_model.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    Widget detailsSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Author: ${book.authorName}', style: const TextStyle(fontSize: 16)),
           if (book.coverId != null) ...[
            const SizedBox(height: 10),
            Text('Cover ID: ${book.coverId}', style: const TextStyle(fontSize: 16)),
          ],
          const SizedBox(height: 10),
          Text('Key: ${book.bookId}', style: const TextStyle(color: Colors.grey)),
            // Description
          if (book.description != null && book.description!.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              book.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15),
            ),
          ],
          if (book.firstPublishYear != null) ...[
            const SizedBox(height: 10),
            Text('First Published: ${book.firstPublishYear}', style: const TextStyle(fontSize: 16)),
          ],
          // Subjects
          if (book.subjects != null && book.subjects!.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'Subjects:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: book.subjects!.take(10).map((subject) {
                return Chip(
                  label: Text(subject),
                  backgroundColor: Colors.blue.shade50,
                );
              }).toList(),
            ),
          ],
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: isTablet
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      book.coverUrl,
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: detailsSection()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    book.coverUrl,
                    height: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                  const SizedBox(height: 20),
                  detailsSection(),
                ],
              ),
      ),
    );
  }
}
