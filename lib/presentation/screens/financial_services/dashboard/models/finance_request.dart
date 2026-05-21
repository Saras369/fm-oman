enum FinanceRequestStatus { approved, pending, rejected }

class FinanceRequest {
  final String id;
  final String name;
  final String date;
  final String approver;
  final FinanceRequestStatus status;

  FinanceRequest({
    required this.id,
    required this.name,
    required this.date,
    required this.approver,
    required this.status,
  });
}
