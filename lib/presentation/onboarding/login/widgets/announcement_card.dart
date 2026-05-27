part of '../view.dart';

class PreAnnouncement {
  final String title, priority, eventDetails, description, postedDate, image;
  final bool scheduled;
  PreAnnouncement({
    required this.title,
    required this.priority,
    required this.eventDetails,
    required this.description,
    required this.postedDate,
    required this.scheduled,
    required this.image,
  });
}

class GovtLoginPage extends ConsumerWidget {
  final List<PreAnnouncement> announcements = [
    PreAnnouncement(
      title: "Oman at GCC",
      priority: "Medium",
      eventDetails: "03 September, 2025",
      description:
          "The meeting discussed means to enhance friendship and cooperation between the GCC states and Japan.",
      postedDate: "12 Aug, 2025",
      scheduled: true,
      image:
          'https://images.unsplash.com/photo-1749573190570-d7e0b14def93?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D%27',
    ),
    PreAnnouncement(
      title: "Oman at GCC",
      priority: "Medium",
      eventDetails: "03 September, 2025",
      description:
          "The meeting discussed means to enhance friendship and cooperation between the GCC states and Japan.",
      postedDate: "12 Aug, 2025",
      scheduled: true,
      image:
          'https://images.unsplash.com/photo-1749573190570-d7e0b14def93?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D%27',
    ),
    PreAnnouncement(
      title: "Oman at GCC",
      priority: "Medium",
      eventDetails: "03 September, 2025",
      description:
          "The meeting discussed means to enhance friendship and cooperation between the GCC states and Japan.",
      postedDate: "12 Aug, 2025",
      scheduled: true,
      image:
          'https://images.unsplash.com/photo-1749573190570-d7e0b14def93?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D%27',
    ),
  ];

  // Example bullet list and usage:
  List<String> infoList = [
    'Sed ut perspiciatis unde omnis iste natus error sit...',
    'Inventore veritatis et quasi architecto beatae vitae...',
    'enim ipsam voluptatem quia voluptas sit aspernatur aut...',
    // ... add more items
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(_vsProvider);
    final stateController = ref.read(_vsProvider.notifier);
    final isLoading = state.isLoading;
    return KScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.security_outlined,
                        size: 30,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Foreign Ministry of OMAN',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'وزارة الخارجية العمانية',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18),

                // PreAnnouncements Card
                Card(
                  color: currentTheme.colors.onPrimary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.campaign,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'PreAnnouncements',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _PreAnnouncementCarousel(announcements: announcements),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 22),

                // Login Box
                Card(
                  color: currentTheme.colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if (isLoading) ...[
                          const LinearProgressIndicator(),
                          const SizedBox(height: 12),
                        ],
                        Text(
                          "Login",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sign in to access your Government Portal",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0XFFF6F6F9),
                              foregroundColor: Colors.black,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black26),
                              ),
                            ),
                            onPressed: isLoading ? null : stateController.signIn,
                            icon: Icon(Icons.lock, color: Colors.black),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue with Microsoft",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[400])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'OR',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[400])),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Sign in with token (optional)',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Paste a Microsoft access token or app auth token',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 12),
                        KTextField(
                          controller: stateController.tokenController,
                          hintText: 'Paste token here',
                          maxLines: 4,
                          isMaxLines: true,
                          minLines: 3,
                          enabled: !isLoading,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: currentTheme.colors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: isLoading
                                ? null
                                : stateController.signInWithPastedToken,
                            child: const Text(
                              'Continue with token',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _FooterColumn(label: "ICAO", value: "Compliant"),
                    _FooterColumn(label: "ISO", value: "Certified"),
                    _FooterColumn(label: "24/7", value: "Support"),
                  ],
                ),
                SizedBox(height: 18),

                // ImportantUpdateCard(
                //   lastUpdate: "09 Sep 2025",
                //   infoList: infoList,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreAnnouncementCarousel extends StatefulWidget {
  final List<PreAnnouncement> announcements;
  const _PreAnnouncementCarousel({required this.announcements});

  @override
  State<_PreAnnouncementCarousel> createState() =>
      _PreAnnouncementCarouselState();
}

class _PreAnnouncementCarouselState extends State<_PreAnnouncementCarousel> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    // Height is set to prevent overflow in card
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: CarouselSlider.builder(
            itemCount: widget.announcements.length,
            itemBuilder: (context, index, realIndex) =>
                _PreAnnouncementBodyCard(
                  announcement: widget.announcements[index],
                ),
            options: CarouselOptions(
              height: 230,
              viewportFraction: 1.0,
              enableInfiniteScroll: widget.announcements.length > 1,
              autoPlay: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) =>
                  setState(() => _current = index),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.announcements.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                color: _current == index ? Colors.black38 : Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PreAnnouncementBodyCard extends StatelessWidget {
  final PreAnnouncement announcement;
  const _PreAnnouncementBodyCard({required this.announcement});
  @override
  Widget build(BuildContext context) {
    // Fixes overflow by making the body scrollable if content is too large
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              announcement.image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  announcement.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                    decoration: TextDecoration.underline,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  announcement.priority,
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            announcement.description,
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text(
            'Event Details : ${announcement.eventDetails}',
            style: TextStyle(color: Colors.black87, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Management',
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Scheduled Event",
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Posted on ${announcement.postedDate}',
            style: TextStyle(color: Colors.grey[600], fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String label, value;
  const _FooterColumn({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 2),
        Text(value, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }
}
