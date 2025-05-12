class IndividualModel {
  final String id;
  final String name;
  final String height;
  final String width;
  final String sleeve;
  final String neckband;
  final String backYoke;
  final String pantsHeight;
  final String paina;
  final String uid;
  final String address;
  final String phoneNo;

  IndividualModel({
    required this.id,
    required this.name,
    required this.height,
    required this.width,
    required this.sleeve,
    required this.neckband,
    required this.backYoke,
    required this.pantsHeight,
    required this.paina,
    required this.uid,
    required this.address,
    required this.phoneNo
  });

  factory IndividualModel.fromMap(Map<String, dynamic> map, String id) {
    return IndividualModel(
      id: id,
      name: map['name'] ?? '',
      height: map['height'] ?? '',
      width: map['width'] ?? '',
      sleeve: map['sleeve'] ?? '',
      neckband: map['neckband'] ?? '',
      backYoke: map['backYoke'] ?? '',
      pantsHeight: map['pantsHeight'] ?? '',
      paina: map['paina'] ?? '',
      uid: map['uid'] ?? '',
        address : map['address'] ?? '',
        phoneNo : map['phoneNo'] ?? '',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'height': height,
      'width': width,
      'sleeve': sleeve,
      'neckband': neckband,
      'backYoke': backYoke,
      'pantsHeight': pantsHeight,
      'paina': paina,
      'uid': uid,
      'address' : address,
      'phoneNo' : phoneNo,
    };
  }
}
