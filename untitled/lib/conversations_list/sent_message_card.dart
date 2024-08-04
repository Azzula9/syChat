import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SentMessageCard extends StatelessWidget {
  final String text;

  const SentMessageCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 10.0),
      child: Column(
        children: [
          Container(
           // margin: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(14.0),
              constraints: BoxConstraints(minHeight: 30,minWidth: 80), // Ensure minimum height
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:188.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 16),
                  onPressed: () {
                    // Add your edit functionality here
                  },

                ),
                IconButton(
                  icon: Icon(Icons.copy, size: 16),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
