part of '../view.dart';

class CollaborationChatView extends ConsumerStatefulWidget {
  final _VSControllerParams params;

  CollaborationChatView({super.key, required this.params});

  @override
  ConsumerState<CollaborationChatView> createState() =>
      _CollaborationChatViewState();
}

class _CollaborationChatViewState extends ConsumerState<CollaborationChatView> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(widget.params));
    final controller = ref.read(_vsProvider(widget.params).notifier);
    final contact = state.selectedContact;

    if (contact == null) return const SizedBox();

    return Column(
      children: [
        // Chat Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: controller.clearSelectedContact,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: contact.color,
                child: Text(
                  contact.initials,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  contact.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              if (contact.conversationType == 'group')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.people_outline, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'People',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Chat Messages List
        Expanded(
          child: Container(
            color: Colors.grey.shade50,
            child: state.isMessagesLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      return _ChatBubble(msg: msg, contact: contact);
                    },
                  ),
          ),
        ),

        // Input Field
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.shade200,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (val) {
                      controller.sendMessage(val);
                      textController.clear();
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    controller.sendMessage(textController.text);
                    textController.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final MessageModel msg;
  final ConversationModel contact;

  const _ChatBubble({required this.msg, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: msg.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isMe) ...[
            CircleAvatar(
              backgroundColor: contact.color,
              radius: 16,
              child: Text(
                msg.senderDisplayName.isNotEmpty
                    ? msg.senderDisplayName[0].toUpperCase()
                    : contact.initials,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: msg.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!msg.isMe)
                Text(
                  msg.senderDisplayName.isNotEmpty
                      ? msg.senderDisplayName
                      : contact.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: msg.isMe ? Colors.grey.shade100 : Colors.white,
                  border: msg.isMe
                      ? null
                      : Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(msg.displayText),
              ),
              SizedBox(height: 4),
              Text(
                msg.displayTime,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
          if (msg.isMe) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.red.shade800,
              radius: 16,
              child: Text(
                'S',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
