class FamilyMembersModel {
  final String name;
  final String relation;
  final String height;
  final String width;
  final String sleeve;
  final String neckband;
  final String backYoke;
  final String pantsHeight;
  final String paina;
  final String uid;
  final String id;

  FamilyMembersModel({
    required this.name,
    required this.relation,
    required this.height,
    required this.width,
    required this.sleeve,
    required this.neckband,
    required this.backYoke,
    required this.pantsHeight,
    required this.paina,
    required this.uid,
    required this.id,
  });

  factory FamilyMembersModel.fromMap(Map<String, dynamic> map) {
    return FamilyMembersModel(
      name: map['name'] ?? '',
      relation: map['relation'] ?? '',
      height: map['height'] ?? '',
      width: map['width'] ?? '',
      sleeve: map['sleeve'] ?? '',
      neckband: map['neckband'] ?? '',
      backYoke: map['backYoke'] ?? '',
      pantsHeight: map['pantsHeight'] ?? '',
      paina: map['paina'] ?? '',
      uid: map['uid'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relation': relation,
      'height': height,
      'width': width,
      'sleeve': sleeve,
      'neckband': neckband,
      'backYoke': backYoke,
      'pantsHeight': pantsHeight,
      'paina': paina,
      'uid': uid,
      'id': id,
    };
  }
}
