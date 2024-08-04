import 'package:flutter/material.dart';
import 'chat_item.dart';

class Section extends StatelessWidget {
  final String title;
  final List<ChatItem> items;

  Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Column(children: items),
        ],
      ),
    );
  }
}
