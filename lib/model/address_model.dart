class AddressModel {
  int? id;
  String? address;
  String? mobile; // Using 'mobile' instead of 'MobileNo'

  AddressModel({this.id, this.address, this.mobile});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    mobile = json['mobile']?.toString();

    // Data validation (optional)
    // if (mobile != null && !isValidPhoneNumber(mobile!)) {
    //   throw FormatException("Invalid phone number format");
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['address'] = address;
    data['mobile'] = mobile;
    return data;
  }

  // Example validation function (customize as needed)
  bool isValidPhoneNumber(String mobile) {
    // Implement your phone number validation logic here
    // This is just a placeholder for demonstration
    return mobile.length >= 10; // Replace with a more robust validation
  }
}
