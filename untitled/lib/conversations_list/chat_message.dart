import 'package:flutter/material.dart';
import 'sent_message_card.dart';
import 'received_message_card.dart';

import '../landing_page.dart';

class ChatMessage extends StatelessWidget {
  final Message message;

  const ChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return message.isSentByMe
        ? SentMessageCard(text: message.text)
        : ReceivedMessageCard(text: message.text);
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../landing_page.dart'; // For Clipboard functionality
//
//
// class ChatMessage extends StatefulWidget {
//   final Message message;
//
//   const ChatMessage({required this.message});
//
//   @override
//   _ChatMessageState createState() => _ChatMessageState();
// }
//
// class _ChatMessageState extends State<ChatMessage> {
//   bool _isMenuOpen = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: widget.message.isSentByMe
//           ? const EdgeInsets.only(left: 50.0, right: 10.0)
//           : const EdgeInsets.only(left: 10.0, right: 50.0),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10.0),
//         alignment: widget.message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
//         child: GestureDetector(
//           onLongPress: widget.message.isSentByMe ? null : () => _showPopupMenu(context),
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             padding: const EdgeInsets.all(14.0), // Adjust padding for smaller size
//             decoration: BoxDecoration(
//               color: widget.message.isSentByMe
//                   ? Colors.grey[300]
//                   : (_isMenuOpen ? Colors.red[700] : Colors.red), // Change color when menu is open
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               widget.message.text,
//               style: TextStyle(
//                 fontSize: 14, // Decrease font size
//                 color: widget.message.isSentByMe ? Colors.black : Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showPopupMenu(BuildContext context) async {
//     final RenderBox cardRenderBox = context.findRenderObject() as RenderBox;
//     final Offset cardOffset = cardRenderBox.localToGlobal(Offset.zero);
//     final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
//
//     setState(() {
//       _isMenuOpen = true;
//     });
//
//     await showMenu(
//       context: context,
//       position: RelativeRect.fromRect(
//         cardOffset & cardRenderBox.size,
//         Offset.zero & overlay.size,
//       ),
//       items: <PopupMenuEntry>[
//         PopupMenuItem(
//           height: 20, // Decrease height for a smaller menu item
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(Icons.volume_up, size: 16), // Adjust icon size
//             title: Text('Read Aloud', style: TextStyle(fontSize: 12)), // Adjust text size
//             onTap: () {
//               // Add your read aloud functionality here
//               Navigator.pop(context);
//               setState(() {
//                 _isMenuOpen = false;
//               });
//             },
//           ),
//         ),
//         PopupMenuDivider(height: 1),
//         PopupMenuItem(
//           height: 20,
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(Icons.copy, size: 16),
//             title: Text('Copy', style: TextStyle(fontSize: 12)),
//             onTap: () {
//               Clipboard.setData(ClipboardData(text: widget.message.text));
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Copied to clipboard')),
//               );
//               setState(() {
//                 _isMenuOpen = false;
//               });
//             },
//           ),
//         ),
//         PopupMenuDivider(height: 1),
//         PopupMenuItem(
//           height: 20,
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(Icons.refresh, size: 16),
//             title: Text('Regenerate', style: TextStyle(fontSize: 12)),
//             onTap: () {
//               // Add your regenerate functionality here
//               Navigator.pop(context);
//               setState(() {
//                 _isMenuOpen = false;
//               });
//             },
//           ),
//         ),
//         PopupMenuDivider(height: 1),
//         PopupMenuItem(
//           height: 20,
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(Icons.thumb_up, size: 16),
//             title: Text('Like', style: TextStyle(fontSize: 12)),
//             onTap: () {
//               // Add your like functionality here
//               Navigator.pop(context);
//               setState(() {
//                 _isMenuOpen = false;
//               });
//             },
//           ),
//         ),
//         PopupMenuDivider(height: 1),
//         PopupMenuItem(
//           height: 20,
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(Icons.thumb_down, size: 16),
//             title: Text('Bad Response', style: TextStyle(fontSize: 12)),
//             onTap: () {
//               // Add your bad response functionality here
//               Navigator.pop(context);
//               setState(() {
//                 _isMenuOpen = false;
//               });
//             },
//           ),
//         ),
//       ],
//       elevation: 8.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//     );
//
//     setState(() {
//       _isMenuOpen = false;
//     });
//   }
// }
