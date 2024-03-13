import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Map<String, dynamic> userProfileData = {};
  late AuthenticationProvider authenticationProvider;

  @override
  void initState() {
    super.initState();

    // Start the confetti loop
    Future.delayed(Duration.zero, () {
      var receivedData = ModalRoute.of(context)!.settings.arguments as String;
      authenticationProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      _loadUserProfileData(authenticationProvider, receivedData);
    });
  }

  Future<void> _loadUserProfileData(authenticationProvider, id) async {
    try {
      userProfileData = await authenticationProvider.getMatchDetail(id!);

      setState(() {});
    } catch (error) {
      // Handle any errors that may occur during data loading
      print("Error loading user profile data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          if (userProfileData.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Chat'),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ), // Show circular progress indicator
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primary,
                title: Text(
                  userProfileData['Name'] ??
                      'Chat', // Use a default value if 'Name' is null
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              body: ChatBody(),
            );
          }
        },
      ),
    );
  }
}

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/home_image.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRseRj5MjxLYtgPrmGHS01YBytPjIkGKk8Zaw&s')),
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type a message...'),
                    onSubmitted: (value) {
                      _sendMessage(value);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
