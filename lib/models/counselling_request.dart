class CounsellingRequest {
  String memberId;
  String reason;
  String status;
  String? counsellorId;
  DateTime requestDate;

  CounsellingRequest({
    required this.memberId,
    required this.reason,
    required this.status,
    this.counsellorId,
    required this.requestDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'reason': reason,
      'status': status,
      'counsellorId': counsellorId,
      'requestDate': requestDate.toIso8601String(),
    };
  }

  factory CounsellingRequest.fromMap(Map<String, dynamic> map) {
    return CounsellingRequest(
      memberId: map['memberId'],
      reason: map['reason'],
      status: map['status'],
      counsellorId: map['counsellorId'],
      requestDate: DateTime.parse(map['requestDate']),
    );
  }
}
