part of '../../view.dart';

class MyProfileWidget extends ConsumerWidget {
  final bool isProfileDetail;
  const MyProfileWidget({super.key, this.isProfileDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(KAppX.theme.current).themeBox;
    final user = ref.watch(userProvider);
    final profile = ref.watch(userProfileDetailsProvider).valueOrNull;

    final displayName = _displayValue(
      profile?.employeeName ?? user?.employeeName,
    );
    final email = _displayValue(profile?.email ?? user?.email);
    final phone = _displayValue(
      profile?.displayPhone,
    );
    final location = _displayValue(profile?.displayLocation);
    final jobTitle = _displayValue(
      profile?.displayJobTitle ?? user?.designationName,
    );

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: const EdgeInsets.all(14),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200, width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 22),
        child: Column(
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.calendar_today, size: 20, color: Color(0xFF22406C)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: currentTheme.fontSizes.s16,
                        color: Color(0xFF22253B),
                      ),
                    ),
                    // SizedBox(height: 3),
                    // Text(
                    //   'Find the Profile Details',
                    //   style: TextStyle(
                    //     fontSize: currentTheme.fontSizes.s15,
                    //     color: Color(0xFF8A919F),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Divider(height: 20),
            // Profile Avatar + name
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 30.toAutoScaledWidth,
                  backgroundColor: Color(0xFFD8DFFC),
                  child: Icon(
                    Icons.person,
                  ), // Replace with your local asset or NetworkImage URL
                  // Use AssetImage or placeholder if needed.
                ),
                Positioned(
                  right: 5.toAutoScaledWidth,
                  bottom: 5.toAutoScaledWidth,
                  child: Container(
                    width: 15.toAutoScaledWidth,
                    height: 15.toAutoScaledWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(1.toAutoScaledWidth),
                      decoration: BoxDecoration(
                        color: Colors.green, // online
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              displayName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: currentTheme.fontSizes.s14,
                color: Color(0xFF23253B),
              ),
            ),
            SizedBox(height: 10.toAutoScaledHeight),

            // Info rows
            _InfoRow(icon: Icons.email, text: email),
            const SizedBox(height: 13),
            _InfoRow(icon: Icons.phone, text: phone),
            const SizedBox(height: 13),
            _InfoRow(icon: Icons.location_on, text: location),
            const SizedBox(height: 13),
            _InfoRow(icon: Icons.business, text: jobTitle),
            const SizedBox(height: 24),
            // View Profile button — disabled for now
            // if (!isProfileDetail)
            //   SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton.icon(
            //       icon: Icon(Icons.arrow_forward, color: Color(0xFF1A2542)),
            //       label: Text(
            //         'View Profile',
            //         style: TextStyle(
            //           color: Color(0xFF1A2542),
            //           fontWeight: FontWeight.w600,
            //           fontSize: currentTheme.fontSizes.s16,
            //         ),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         elevation: 0,
            //         backgroundColor: Colors.white,
            //         side: BorderSide(color: Color(0xFFCED8ED), width: 1.2),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         padding: const EdgeInsets.symmetric(vertical: 13),
            //       ),
            //       onPressed: () {
            //         KAppX.router.push(ProfileDetailsRoute());
            //       },
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  static String _displayValue(String? value) {
    if (value == null || value.trim().isEmpty) return '—';
    return value.trim();
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      children: [
        Icon(icon, color: Color(0xFF192362), size: 18),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s14,
              color: Color(0xFF22253C),
            ),
          ),
        ),
      ],
    );
  }
}
