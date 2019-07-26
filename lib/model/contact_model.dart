/// 联系人信息
class ContactInfo {
  String name;
  String avatar;
  int sex;
  String tagIndex;
  String namePinyin;

  ContactInfo(
      {this.name, this.avatar, this.sex, this.tagIndex, this.namePinyin});

  Map<String, dynamic> toJson() {
    return {'name': name, 'avatar': avatar, 'sex': sex};
  }

  @override
  String toString() {
    return super.toString();
  }
}
