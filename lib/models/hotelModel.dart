class Hotel {

  String hotelid;
  String hotelName;
  String email;
  String location;
  String description;
  String phoneNum;
  String pool;
  String parking;
  String spa;
  String bar;
  String wifi;
  String hotelImg;
  
 
  Hotel({this.hotelid,this.hotelName,this.email,this.location,this.description,this.phoneNum,this.pool,this.parking,this.spa,this.bar,this.wifi,this.hotelImg});
 
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(

      hotelid: json["_id"] as String,
      hotelName: json["name"] as String,
      email: json["email"] as String,
      location: json["location"] as String,
      description: json["description"] as String,
      phoneNum: json["phone_number"] as String,
      pool: json["pool"] as String,
      parking: json["parking"] as String,
      spa: json["spa"] as String,
      bar: json["bar"] as String,
      wifi: json["wifi"] as String,
      hotelImg: json["hotelImage"] as String,
    );
  }
}