part of '../view.dart';

/// ----------------------
/// Custom Info Card Widget
/// ----------------------
class CustomInfoCard extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final List<SubServices> subServices;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;
  final VoidCallback? onPressSubService;
  final int serviceId;

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.subServices,
    required this.isBookmarked,
    this.onBookmarkToggle,
    this.onPressSubService,
    required this.serviceId,
  });

  @override
  ConsumerState<CustomInfoCard> createState() => _CustomInfoCardState();
}

class _CustomInfoCardState extends ConsumerState<CustomInfoCard> {
  bool _showAllSubServices = false;

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final state = ref.watch(allServicesVSProvider);
    final stateController = ref.watch(allServicesVSProvider.notifier);

    final hasMoreThanThree = widget.subServices.length > 3;

    // Decide which subservices to show based on expanded/collapsed state
    final visibleSubServices = _showAllSubServices || !hasMoreThanThree
        ? widget.subServices
        : widget.subServices.take(3).toList();

    final isArabic = ref.watch(appLocaleProvider).languageCode == 'ar';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          stateController.onPressSubService(
            widget.subServices,
            widget.serviceId,
          );
          widget.onPressSubService?.call();
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: widget.iconColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(widget.icon, color: widget.iconColor),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: currentTheme.fontSizes.s16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    /// Bookmark Icon
                    GestureDetector(
                      onTap: widget.onBookmarkToggle,
                      child: Icon(
                        widget.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: widget.isBookmarked ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  widget.subtitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: currentTheme.fontSizes.s12,
                  ),
                ),

                const SizedBox(height: 8),

                if (widget.subServices.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      // Visible subservices
                      ...visibleSubServices.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0XFFF6F6F9),
                          ),
                          child: Text(
                            isArabic
                                ? tag.arabicName ?? ''
                                : tag.subServiceName ?? '',
                            style: TextStyle(
                              fontSize: currentTheme.fontSizes.s12,
                            ),
                          ),
                        );
                      }).toList(),

                      // More / Less button
                      if (hasMoreThanThree)
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showAllSubServices = !_showAllSubServices;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0XFF78909C),
                            ),
                            child: Text(
                              _showAllSubServices ? '- Less' : '+ More',
                              style: TextStyle(
                                fontSize: currentTheme.fontSizes.s12,
                                fontWeight: FontWeight.w500,
                                color: currentTheme.colors.onPrimary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
