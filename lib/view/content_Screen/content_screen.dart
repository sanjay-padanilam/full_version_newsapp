import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  ContentScreen({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 200,
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
            // Padding for content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // News Content
                  Text(
                    content,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button for sharing
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement sharing functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Share functionality not implemented")),
          );
        },
        child: Icon(Icons.share),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
