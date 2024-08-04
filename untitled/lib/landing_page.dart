import 'package:flutter/material.dart';
import 'conversations_list/sent_message_card.dart';
import 'conversations_list/received_message_card.dart';
import 'conversations_list/conversations_page.dart';

class LandingPage extends StatefulWidget {
  final bool startNewConversation;

  LandingPage({this.startNewConversation = false});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> chatList = [
    'Tell me about\nthe latest data plans and offers?',
    'How can I\ntransfer my number to a new SIM?',
  ];
  final List<List<Message>> conversations = [];
  List<Message> messages = [];
  TextEditingController _controller = TextEditingController();
  bool _isTextFieldEmpty = true;
  bool _showInitialContent = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextFieldEmpty = _controller.text.isEmpty;

      });
    });

    if (widget.startNewConversation) {
      _startNewConversation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(String messageText) {
    setState(() {
      messages.add(Message(text: messageText, isSentByMe: true));
      messages.add(Message(
          text: "Thanks for asking about the internet plans! Actually, we don't have a plan for exactly 6GB, but we do have a great option that includes 4GB of internet along with 3GB for Social Media, which is valid for 15 days and costs 30,000 SYP. Would this plan work for you, or can I help with other inquiries?",
          isSentByMe: false));
      _controller.clear();
      _showInitialContent = false;
    });
  }




  void _startNewConversation() {
    if (messages.isNotEmpty) {
      setState(() {
        conversations.add(List.from(messages)); // Store current messages
        messages.clear(); // Clear messages for new conversation
        _showInitialContent = true; // Show initial content for new conversation
      });
    }
  }
  void showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Export Conversation'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading: Image.asset('Assets/images/pdf_icon.png', width: 30, height: 30),
              title: Text('Export to PDF'),
              // trailing: Icon(Icons.download),
              // onTap: () {
              //   // Add your export to PDF functionality here
              //   Navigator.of(context).pop();
              // },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
              child: Text('Confirm'),
              onPressed: () {
                // Add your confirmation functionality here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Send us a Feedback'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('We care about your experience!'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Your message...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
              child: Text('Submit'),
              onPressed: () {
                // Add your submit feedback functionality here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust position as needed
      items: [
        PopupMenuItem<String>(
          value: 'export',
          child: Row(
            children: [
              Icon(Icons.download,color: Colors.grey),
              SizedBox(width: 10),
              Text('Export'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'feedback',
          child: Row(
            children: [
              Icon(Icons.feedback,color: Colors.grey),
              SizedBox(width: 10),
              Text('Send feedback'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'export') {
        showExportDialog(context);
      } else if (value == 'feedback') {
        showFeedbackDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConversationsPage()),
            );
          },
        ),
        title: Text('SyrBot'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _startNewConversation,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showPopupMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_showInitialContent) ...[
                    Image.asset(
                      'Assets/images/Syriatel_Logo.jpg', // Replace with your image path
                      height: 100, // Adjust the height as needed
                      width: 250, // Adjust the width as needed
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'Hi! What would you like\nassistance with?',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Last Update: 12.02.24',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 200), // Adjust spacing as needed
                    ...chatList.map((text) => OptionCard(
                      text: text,
                      onTap: () => _sendMessage(text),
                    )).toList(),
                  ],
                  ...messages.map((message) => message.isSentByMe
                      ? SentMessageCard(text: message.text)
                      : ReceivedMessageCard(text: message.text)).toList(),
                ],
              ),
            ),
          ),
          BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Ask me anything...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isTextFieldEmpty ? Icons.mic : Icons.send,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (!_isTextFieldEmpty) {
                          _sendMessage(_controller.text);
                        }

                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const OptionCard({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.fiber_manual_record, color: Colors.red, size: 12),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16), // Adjust text size as needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}
