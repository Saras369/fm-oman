class ClubCardDiplomaticTitleModel {
  final bool success;
  final String message;
  final List<ClubCardDiplomaticTitleItem> data;

  ClubCardDiplomaticTitleModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClubCardDiplomaticTitleModel.fromJson(Map<String, dynamic> json) {
    return ClubCardDiplomaticTitleModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ClubCardDiplomaticTitleItem.fromJson(e))
          .toList(),
    );
  }
}

class ClubCardDiplomaticTitleItem {
  final int id;
  final String title;
  final String category;

  ClubCardDiplomaticTitleItem({
    required this.id,
    required this.title,
    required this.category,
  });

  factory ClubCardDiplomaticTitleItem.fromJson(Map<String, dynamic> json) {
    return ClubCardDiplomaticTitleItem(
      id: json['id'],
      title: json['title'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
