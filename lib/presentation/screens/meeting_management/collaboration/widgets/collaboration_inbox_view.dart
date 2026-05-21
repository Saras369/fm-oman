part of '../view.dart';

class CollaborationInboxView extends ConsumerWidget {
  final _VSControllerParams params;

  const CollaborationInboxView({super.key, required this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(params));
    final controller = ref.read(_vsProvider(params).notifier);

    return Column(
      children: [
        // Inbox Header area (Title and Add button)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inbox',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NewChatView()),
                    ).then((onValue) {
                      controller.fetchConversations();
                    });
                  },
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.all(4),
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: controller.searchContacts,
              decoration: InputDecoration(
                hintText: 'Search Conversation',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        // Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              _buildFilterTab('All', state.activeFilter == 'All', controller),
              SizedBox(width: 8),
              _buildFilterTab(
                'Groups',
                state.activeFilter == 'Groups',
                controller,
              ),
              SizedBox(width: 8),
              _buildFilterTab(
                'Unread',
                state.activeFilter == 'Unread',
                controller,
              ),
            ],
          ),
        ),

        // Contacts List
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: state.filteredContacts.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final contact = state.filteredContacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: contact.color,
                  child: Text(
                    contact.initials,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  contact.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Text(
                  contact.lastMessageText,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                trailing: Text(
                  contact.timeStr,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () => controller.selectContact(contact),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(
    String title,
    bool isActive,
    _VSController controller,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setFilter(title),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? Colors.black : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
