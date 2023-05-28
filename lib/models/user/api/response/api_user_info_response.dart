class ApiUserInfoResponse {
  String? userid;
  String? phone;
  String? normalphone;
  String? realname;
  String? nickname;
  String? account;
  String? email;
  String? idnumber;
  String? scores;
  String? address;
  String? gender;
  String? invitecode;
  String? inviterole;
  String? showcommission;
  String? headimg;
  String? showname;
  String? regmode;
  String? wxnickname;
  bool? wxsubscription;
  String? commonpower;

  ApiUserInfoResponse(
      {this.userid,
      this.phone,
      this.normalphone,
      this.realname,
      this.nickname,
      this.account,
      this.email,
      this.idnumber,
      this.scores,
      this.address,
      this.gender,
      this.invitecode,
      this.inviterole,
      this.showcommission,
      this.headimg,
      this.showname,
      this.regmode,
      this.wxnickname,
      this.wxsubscription,
      this.commonpower});

  ApiUserInfoResponse.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    phone = json['phone'];
    normalphone = json['normalphone'];
    realname = json['realname'];
    nickname = json['nickname'];
    account = json['account'];
    email = json['email'];
    idnumber = json['idnumber'];
    scores = json['scores'];
    address = json['address'];
    gender = json['gender'];
    invitecode = json['invitecode'];
    inviterole = json['inviterole'];
    showcommission = json['showcommission'];
    headimg = json['headimg'];
    showname = json['showname'];
    regmode = json['regmode'];
    wxnickname = json['wxnickname'];
    wxsubscription = json['wxsubscription'];
    commonpower = json['commonpower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['phone'] = this.phone;
    data['normalphone'] = this.normalphone;
    data['realname'] = this.realname;
    data['nickname'] = this.nickname;
    data['account'] = this.account;
    data['email'] = this.email;
    data['idnumber'] = this.idnumber;
    data['scores'] = this.scores;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['invitecode'] = this.invitecode;
    data['inviterole'] = this.inviterole;
    data['showcommission'] = this.showcommission;
    data['headimg'] = this.headimg;
    data['showname'] = this.showname;
    data['regmode'] = this.regmode;
    data['wxnickname'] = this.wxnickname;
    data['wxsubscription'] = this.wxsubscription;
    data['commonpower'] = this.commonpower;
    return data;
  }
}
