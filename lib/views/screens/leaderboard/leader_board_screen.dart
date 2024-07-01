import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/controllers/leaderboard_controller.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder(
        stream: context.read<LeaderboardController>().list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null || !snapshot.hasData) {
            return const Center(
              child: Text("No Records"),
            );
          }

          final records = snapshot.data!.docs;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final email = records[index]['email'];
              final points = records[index]['points'];
              return ListTile(
                leading: Text("${index + 1}"),
                title: Text("$email"),
                subtitle: Text("$points"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
