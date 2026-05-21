part of '../view.dart';

class AppointmentRequest {
  final String id;
  final String name;
  final String date;
  final String approver;
  final RequestStatus status;

  AppointmentRequest({
    required this.id,
    required this.name,
    required this.date,
    required this.approver,
    required this.status,
  });
}

enum RequestStatus { approved, pending, rejected }

class AppointmentRequestsCardMobile extends StatefulWidget {
  final List<AppointmentRequest> actionItems;

  const AppointmentRequestsCardMobile({super.key, required this.actionItems});

  @override
  State<AppointmentRequestsCardMobile> createState() =>
      _AppointmentRequestsCardMobileState();
}

class _AppointmentRequestsCardMobileState
    extends State<AppointmentRequestsCardMobile> {
  @override
  Widget build(BuildContext context) {
    final items = widget.actionItems;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: EdgeInsets.all(8.toAutoScaledWidth),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) =>
                _AppointmentRequestCardMobileItem(request: items[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              'Leave Requests',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _IconButton(
              icon: Icons.add,
              onTap: () {
                KAppX.extendedRouter.dialog.showKDialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 20.toAutoScaledWidth,
                  ),

                  builder: (context) {
                    return Container();
                  },
                );
              },
            ),
            const SizedBox(width: 8),
            _IconButton(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
        10.toVerticalSizedBox,
        _SearchBar(),
      ],
    );
  }
}

class _AppointmentRequestCardMobileItem extends StatelessWidget {
  final AppointmentRequest request;

  const _AppointmentRequestCardMobileItem({required this.request});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: currentTheme.colors.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Appointment ID:', request.id, textTheme),
            const SizedBox(height: 6),
            _buildRow('Appointment Type:', request.name, textTheme),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _buildRow('Scheduled Date:', request.date, textTheme),
                ),
                Expanded(
                  child: _buildRow('Approver:', request.approver, textTheme),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _StatusBadgeMobile(status: request.status),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.open_in_new),
                  color: const Color(0xFF23272F),
                  onPressed: () {
                    KAppX.router.push(AppointmentDetailsRoute());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, TextTheme theme) {
    return RichText(
      text: TextSpan(
        style: theme.bodyMedium?.copyWith(
          color: const Color(0xFF23272F),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _StatusBadgeMobile extends StatelessWidget {
  final RequestStatus status;
  const _StatusBadgeMobile({required this.status});

  @override
  Widget build(BuildContext context) {
    late Color bgColor;
    late Color textColor;
    late IconData icon;
    late String label;

    switch (status) {
      case RequestStatus.approved:
        bgColor = const Color(0xFFC9F1DF);
        textColor = const Color(0xFF31B480);
        icon = Icons.check_circle_outline;
        label = "Approved";
        break;
      case RequestStatus.pending:
        bgColor = const Color(0xFFFDF5DF);
        textColor = const Color(0xFFF4B31C);
        icon = Icons.access_time;
        label = "Pending";
        break;
      case RequestStatus.rejected:
        bgColor = const Color(0xFFFFE2E2);
        textColor = const Color(0xFFD13239);
        icon = Icons.cancel_outlined;
        label = "Rejected";
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  const TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: selected ? Colors.black : const Color(0xFFEBECF0),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? Colors.white : const Color(0xFF5E6D88),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF8693A7),
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Color(0xFFF4F6F8),
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon, size: 24, color: const Color(0xFFB3BCC5)),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          Icon(Icons.search, size: 20, color: Color(0xFFB3BCC5)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by Request Name or Request ID',
                isDense: true,
                hintStyle: TextStyle(
                  color: Color(0xFFB3BCC5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
