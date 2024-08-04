import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceivedMessageCard extends StatefulWidget {
  final String text;

  const ReceivedMessageCard({required this.text});

  @override
  _ReceivedMessageCardState createState() => _ReceivedMessageCardState();
}

class _ReceivedMessageCardState extends State<ReceivedMessageCard> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 50.0),
      child: Column(
        children: [
          Container(
         //   margin: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onLongPress: () => _showPopupMenu(context),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: _isMenuOpen ? Colors.red[700] : Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 188.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.volume_up, size: 16),
                  onPressed: () {
                    // Add your volume up functionality here
                  },

                ),
                IconButton(
                  icon: Icon(Icons.refresh, size: 16),
                  onPressed: () {
                    // Add your regenerate functionality here
                  },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox cardRenderBox = context.findRenderObject() as RenderBox;
    final Offset cardOffset = cardRenderBox.localToGlobal(Offset.zero);
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    setState(() {
      _isMenuOpen = true;
    });

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        cardOffset & cardRenderBox.size,
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          height: 20,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.volume_up, size: 16),
            title: Text('Read Aloud', style: TextStyle(fontSize: 12)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem(
          height: 20,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.copy, size: 16),
            title: Text('Copy', style: TextStyle(fontSize: 12)),
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.text));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied to clipboard')),
              );
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem(
          height: 20,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.refresh, size: 16),
            title: Text('Regenerate', style: TextStyle(fontSize: 12)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem(
          height: 20,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.thumb_up, size: 16),
            title: Text('Like', style: TextStyle(fontSize: 12)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem(
          height: 20,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.thumb_down, size: 16),
            title: Text('Bad Response', style: TextStyle(fontSize: 12)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    setState(() {
      _isMenuOpen = false;
    });
  }
}
