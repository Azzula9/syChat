import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPinned;
  final bool isSelected;
  final bool isSelecting;
  final Function onTap;
  final Function onLongPress;

  ChatItem({
    required this.title,
    required this.subtitle,
    this.isPinned = false,
    this.isSelected = false,
    this.isSelecting = false,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      onLongPress: () => onLongPress(),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        color: isSelected ? Colors.grey[300] : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: isSelecting ? (isSelected ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.radio_button_unchecked, color: Colors.grey)) : null,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: isPinned ? Icon(Icons.push_pin, color: Colors.red) : null,
        ),
      ),
    );
  }
}
