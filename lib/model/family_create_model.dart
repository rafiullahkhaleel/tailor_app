class FamilyCreateModel {
  final String headName;
  final String phoneNo;
  final String id;
  final String uid;

  FamilyCreateModel({
    required this.headName,
    required this.phoneNo,
    required this.id,
    required this.uid,
  });

  factory FamilyCreateModel.fromMap(Map<String, dynamic> map) {
    return FamilyCreateModel(
      headName: map['headName'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'headName': headName,
      'phoneNo': phoneNo,
      'id': id,
      'uid': uid,
    };
  }
}
