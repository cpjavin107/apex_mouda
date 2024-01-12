class MemberData {
  int? status;
  String? msg;
  List<Null>? ads;
  List<Data>? data;

  MemberData({this.status, this.msg, this.ads, this.data});

  MemberData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    // if (json['ads'] != null) {
    //   ads = <Null>[];
    //   json['ads'].forEach((v) {
    //     ads!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    // if (this.ads != null) {
    //   data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    // }
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? address;
  String? image;
  String? phone;
  String? profession;
  String? dealsInId;
  String? dealsInName;
  String? executiveMemberStatus;
  String? executiveMemberDesignationId;
  String? executiveMemberDesignationName;
  String? addFirmDetailStatus;
  String? firmName;
  String? firmAddress;
  String? firmPhone;
  String? firmPhone2;
  String? firmEmail;
  String? firmLogo;
  String? executivePatronLifeMember;
  String? nameOfTheMember;
  String? nameOfSpouse;
  String? contactNumber;
  String? dob;
  String? dateOfJoining;
  String? receiptNo;
  String? marriageAnniversary;
  String? emailId;
  String? presentAddress;
  String? officeAddress;
  String? permanentAddress;
  String? fatherName;
  String? motherName;
  List<ChildrenDetails>? childrenDetails;
  String? anyOtherInformation;
  String? createdAt;
  String? updatedAt;
  String? mcId;
  String? ownerId;
  String? designation;
  String? mcJoiningDate;
  String? mcEndingDate;
  String? mcStatus;
  String? addedDate;
  String? mtMemberType;
  String? mcName;

  Data(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.image,
        this.phone,
        this.profession,
        this.dealsInId,
        this.dealsInName,
        this.executiveMemberStatus,
        this.executiveMemberDesignationId,
        this.executiveMemberDesignationName,
        this.addFirmDetailStatus,
        this.firmName,
        this.firmAddress,
        this.firmPhone,
        this.firmPhone2,
        this.firmEmail,
        this.firmLogo,
        this.executivePatronLifeMember,
        this.nameOfTheMember,
        this.nameOfSpouse,
        this.contactNumber,
        this.dob,
        this.dateOfJoining,
        this.receiptNo,
        this.marriageAnniversary,
        this.emailId,
        this.presentAddress,
        this.officeAddress,
        this.permanentAddress,
        this.fatherName,
        this.motherName,
        this.childrenDetails,
        this.anyOtherInformation,
        this.createdAt,
        this.updatedAt,
        this.mcId,
        this.ownerId,
        this.designation,
        this.mcJoiningDate,
        this.mcEndingDate,
        this.mcStatus,
        this.addedDate,
        this.mtMemberType,
        this.mcName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
    phone = json['phone'];
    profession = json['profession'];
    dealsInId = json['deals_in_id'];
    dealsInName = json['deals_in_name'];
    executiveMemberStatus = json['executive_member_status'];
    executiveMemberDesignationId = json['executive_member_designation_id'];
    executiveMemberDesignationName = json['executive_member_designation_name'];
    addFirmDetailStatus = json['add_firm_detail_status'];
    firmName = json['firm_name'];
    firmAddress = json['firm_address'];
    firmPhone = json['firm_phone'];
    firmPhone2 = json['firm_phone2'];
    firmEmail = json['firm_email'];
    firmLogo = json['firm_logo'];
    executivePatronLifeMember = json['executive_patron_life_member'];
    nameOfTheMember = json['name_of_the_member'];
    nameOfSpouse = json['name_of_spouse'];
    contactNumber = json['contact_number'];
    dob = json['dob'];
    dateOfJoining = json['date_of_joining'];
    receiptNo = json['receipt_no'];
    marriageAnniversary = json['marriage_anniversary'];
    emailId = json['email_id'];
    presentAddress = json['present_address'];
    officeAddress = json['office_address'];
    permanentAddress = json['permanent_address'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    if (json['children_details'] != null) {
      childrenDetails = <ChildrenDetails>[];
      json['children_details'].forEach((v) {
        childrenDetails?.add(new ChildrenDetails.fromJson(v));
      });
    }
    anyOtherInformation = json['any_other_information'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mcId = json['mc_id'];
    ownerId = json['owner_id'];
    designation = json['designation'];
    mcJoiningDate = json['mc_joining_date'];
    mcEndingDate = json['mc_ending_date'];
    mcStatus = json['mc_status'];
    addedDate = json['added_date'];
    mtMemberType = json['mt_member_type'];
    mcName = json['mc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['profession'] = this.profession;
    data['deals_in_id'] = this.dealsInId;
    data['deals_in_name'] = this.dealsInName;
    data['executive_member_status'] = this.executiveMemberStatus;
    data['executive_member_designation_id'] = this.executiveMemberDesignationId;
    data['executive_member_designation_name'] =
        this.executiveMemberDesignationName;
    data['add_firm_detail_status'] = this.addFirmDetailStatus;
    data['firm_name'] = this.firmName;
    data['firm_address'] = this.firmAddress;
    data['firm_phone'] = this.firmPhone;
    data['firm_phone2'] = this.firmPhone2;
    data['firm_email'] = this.firmEmail;
    data['firm_logo'] = this.firmLogo;
    data['executive_patron_life_member'] = this.executivePatronLifeMember;
    data['name_of_the_member'] = this.nameOfTheMember;
    data['name_of_spouse'] = this.nameOfSpouse;
    data['contact_number'] = this.contactNumber;
    data['dob'] = this.dob;
    data['date_of_joining'] = this.dateOfJoining;
    data['receipt_no'] = this.receiptNo;
    data['marriage_anniversary'] = this.marriageAnniversary;
    data['email_id'] = this.emailId;
    data['present_address'] = this.presentAddress;
    data['office_address'] = this.officeAddress;
    data['permanent_address'] = this.permanentAddress;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    if (this.childrenDetails != null) {
      data['children_details'] =
          this.childrenDetails?.map((v) => v.toJson()).toList();
    }
    data['any_other_information'] = this.anyOtherInformation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mc_id'] = this.mcId;
    data['owner_id'] = this.ownerId;
    data['designation'] = this.designation;
    data['mc_joining_date'] = this.mcJoiningDate;
    data['mc_ending_date'] = this.mcEndingDate;
    data['mc_status'] = this.mcStatus;
    data['added_date'] = this.addedDate;
    data['mt_member_type'] = this.mtMemberType;
    data['mc_name'] = this.mcName;
    return data;
  }
}

class ChildrenDetails {
  String? id;
  String? memberId;
  String? name;
  String? remark;

  ChildrenDetails({this.id, this.memberId, this.name, this.remark});

  ChildrenDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    name = json['name'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['name'] = this.name;
    data['remark'] = this.remark;
    return data;
  }
}
