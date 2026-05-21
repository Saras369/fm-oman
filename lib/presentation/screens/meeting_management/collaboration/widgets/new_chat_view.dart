import 'package:code_setup/presentation/screens/meeting_management/collaboration/new_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';

class NewChatView extends ConsumerWidget {
  const NewChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newChatControllerProvider);
    final controller = ref.read(newChatControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search Users', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected Users Chips
          if (state.selectedUsers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: state.selectedUsers.map((user) {
                  final color = _getColorForUser(user.userName ?? '?');
                  return Chip(
                    label: Text(
                      user.userName ?? 'Unknown',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      child: Text(
                        _getInitials(user.userName ?? ''),
                        style: TextStyle(color: color.shade900, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    backgroundColor: color.shade100,
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => controller.removeUser(user),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: color.shade200),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: controller.searchUsers,
                decoration: InputDecoration(
                  hintText: 'Name, E-mail, Employee ID...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // List of searched users
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : state.searchResults.isEmpty && state.searchQuery.isNotEmpty
                    ? const Center(child: Text("No users found"))
                    : ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final user = state.searchResults[index];
                          final initials = _getInitials(user.userName ?? ' ');
                          final color = _getColorForUser(user.userName ?? ' ');

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: color.shade100,
                              child: Text(
                                initials,
                                style: TextStyle(
                                  color: color.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(user.userName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('${user.email ?? ''}'),
                            onTap: () => controller.addUser(user),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: state.selectedUsers.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(Icons.check, color: Colors.white),
              onPressed: () async {
                final int currentUserId = KAppX.globalProvider.read(userProvider)?.userId ?? 109;
                final success = await controller.startChat(currentUserId);
                if (success && context.mounted) {
                   Navigator.pop(context, true);
                } else if (context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Failed to start chat'), backgroundColor: Colors.red),
                   );
                }
              },
            )
          : null,
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  MaterialColor _getColorForUser(String name) {
    final colors = [
      Colors.cyan,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.orange,
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
    ];
    final hash = name.codeUnits.fold(0, (prev, curr) => prev + curr);
    return colors[hash % colors.length];
  }
}
