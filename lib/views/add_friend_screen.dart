import 'package:flutter/material.dart';
import 'package:mental_wellness_app/controllers/add_friend_controller.dart';
import 'package:provider/provider.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  late AddFriendController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AddFriendController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFriendController>(
      create: (_) => _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Friend"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controller.emailController,
                  decoration: const InputDecoration(
                    labelText: "Friend's Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.sendFriendRequest,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigo[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Send Request"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
