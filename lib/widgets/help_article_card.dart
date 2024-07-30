import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String url;
  final String website;

  ArticleCard({required this.title, required this.url, required this.website});

  String _addHttpIfNeeded(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.indigo[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
          // textAlign: TextAlign.justify,
        ),
        subtitle: Text(
          website,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Icon(Icons.open_in_new, color: Colors.white),
        onTap: () => _launchURL(url),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri articleUrl = Uri.parse(_addHttpIfNeeded(url));
    try {
      await launchUrl(articleUrl);
    } catch (e) {
      throw 'Could not launch $articleUrl';
    }
  }
}
