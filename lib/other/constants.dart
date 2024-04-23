import 'dart:io';

import 'package:flutter/material.dart';

class AppConstants {
  static String baseUrl = 'https://sortmycollegeapp.com';
  static String counsellorlistEndpoint = '/counsellor/';
  static String sendotpRequest = '/user/auth/sendOTPEmail';
  static String sendotpphoneRequest = '/user/auth/sendOTPPhone';
  static String verifyotpRequest = '/user/auth/verifyOTPEmail';
  static String verifyotpphoneRequest = '/user/auth/verifyOTPPhone';
  static const imagePath = "assets/page-1/images/";
  static const appName = "sortmycollege";
  static const packageId = "com.sortmycollege";
  static const txt_haveac = "Already have an account";
  static const txt_noac = "Don't have an account?";
  static const txt_login = "LOGIN";
  static const txt_info = "Info";
  static const txt_card_info = "CARD INFO";
  static const txt_card_edit = "CARD EDIT";
  static const txt_profile = "Profile";
  static const txt_scan = "Scan";
  static const txt_next = "NEXT";
  static const txt_checkin = "Check In";
  static const txt_proceed = "PROCEED";
  static const txt_submit = "SUBMIT";
  static const txt_edit = "EDIT CARD";
  static const txt_delete = "DELETE CARD";
  static const txt_register = "REGISTER";
  static const txt_addcard = "ADD CARD";
  static const txt_inst_search = "SEARCH INSTITUTION";
  static const txt_inst_details = "INSTITUTION DETAILS";
  static const txt_user_reg = "USER REGISTRATION";
  static const txt_card_det = "CARD DETAILS";
  static const txt_insname = "Name of Institution";
  static const txt_cityname = "Name of City";
  static const txt_citynameenter = "Enter the City Name";
  static const txt_country = "Country";
  static const txt_website = "Website";
  static const txt_role = "Your Role";
  static const txt_fullname = "Full Name";
  static const txt_email = "Email";
  static const txt_otp = "OTP";
  static const txt_idcardstitle = "ID Cards";
  static const txt_idcards = "No. Of Id Cards Required";
  static const txt_insnamee = "Enter institution name";
  static const txt_countrye = "Enter country";
  static const txt_countryse = "Select Country";
  static const txt_cityse = "Select City";
  static const txt_websitee = "Enter website";
  static const txt_rolee = "Enter your role";
  static const txt_fullnamee = "Enter full name";
  static const txt_emaile = "Enter email";
  static const txt_idcardse = "Enter no. of id cards required";
  static const txt_selfid = "SELF ID";
  static const txt_insti = "INSTITUTION";
  static const txt_already_inst = "Already Registered Institution User?";
  static const txt_instiid = "ADD INSTITUTION ISSUE ID";
  static const txt_instadd = "Add Institution";
  static const txt_clr_data = "Clear Cache";
  static const txt_save = "Save";
  static const txt_selcat = "Select your category";
  static const txt_fname = "First Name";
  static const txt_efname = "Enter first name";
  static const txt_lname = "Last Name";
  static const txt_appinfoappname = "App Name";
  static const txt_appinfoversion = "Version";
  static const txt_elname = "Enter last name";
  static const txt_dob = "Date Of Birth";
  static const txt_edob = "Select date of birth";
  static const txt_phonenumber = "Phone Number";
  static const txt_ephonenumber = "Enter phone number";
  static const txt_email1 = "Email";
  static const txt_eemail1 = "Enter email";
  static const txt_password = "Password";
  static const txt_epassword = "Enter password";
  static const txt_website1 = "Website";
  static const txt_ewebsite1 = "Enter website";
  static const txt_role1 = "Role";
  static const txt_erole1 = "Enter role";
  static const txt_country1 = "Country";
  static const txt_ecountry1 = "Enter country";
  static const txt_city = "City";
  static const txt_ecity = "Enter city";
  static const txt_insti1 = "Institution";
  static const txt_einsti1 = "Enter institution";
  static const txt_noofcards = "No. Of Id Cards Required";
  static const txt_enoofcards = "Enter no. of id cards required";
  static const fnameerror = "Please enter first name";
  static const lnameerror = "Please enter last name";
  static const doberror = "Please select date of birth";
  static const phoneerror = "Please enter phone number";
  static const phonenotvalid = "Please enter vlaid phone number";

  static const emailerror = "Please enter email";
  static const emailvaliderror = "Please enter valid email";
  static const otperror = "Please enter OTP";
  static const otpvalid = "Please enter valid OTP";
  static const otpinvalid = "Invalid OTP";
  static const passworderror = "Please enter password";
  static const websiteerror = "Please enter website";
  static const websitepropererror = "Please enter valid website";
  static const roleerror = "Please enter role";
  static const countryerror = "Please select country";
  static const cityerror = "Please select city";
  static const stateerror = "Please select state";
  static const institutionerror = "Please select institution";
  static const noofcardserror = "Please enter no. of cards";
  static const something_wrong = "Something went wrong, please try again!";
  static const profile_data_unavailable = "No Profile Data available";
  static const resend_otp_success = "Otp Sent Successfully!";
  static const reg_success = "Registration Successful!";
  static const add_card_success = "ID Card added Successfully!";
  static const edit_card_success = "ID Card Updated Successfully!";
  static const proupdate_success = "Profile Updated Successfully!";
  static const carddelete_success = "ID Card Deleted Successful!";
  static const notiremove_success = "Notification removed Successfully!";
  static const login_success = "Logged in successfully!";
  static const instnameerror = "Please enter institution name";
  static const fullnameerror = "Please enter full name";
  static const txt_dash = "Dashboard";
  static const txt_appinfo = "App Info";
  static const txt_sel_inst = "SELECT INSTITUTION";
  static const txt_termsandconditions = "Terms And Conditions";
  static const txt_manage = "Manage";
  static const txt_noti = "Notifications";
  static const IS_LOGGEDIN = "isloggedin";
  static const TOKEN_API = "apitoken";
  static const TOKEN_EXPIRY = "tokenexpiry";
  static const USER_TYPE = "user_type";
  static const USER_ID = "user_id";
  static const LAST_PUNCH = "last_punch";
  static const USER_EMAIL = "user_email";
  static const USER_NAME = "user_name";
  static const txt_search = "Search";
  static const sel_institition = "SELECT INSTITUTION";
  static const add_photo = "ADD ID PHOTO";
  static const take_photo = "TAKE PHOTO";
  static const uplaod_photo = "UPLOAD PHOTO";
  static const conf_proceed = "CONFIRM & PROCEED";
  static const add_card = "ADD CARD";
  static const namelengtherror =
      "Institution name should be at least three characters long!";
  //static const emailerror= "Please enter email";
  static const countrylengtherror =
      "Country should be at least two characters long!";
  static const citylengtherror = "City should be at least two characters long!";
  static const txt_nocompany = "No Institution Available!";
  static const txt_nonoti = "No Notifications!";
  static const txt_nocards = "No Cards Available!";
  static const txt_logout = "Logout";
  static const txt_delete_alert = "Delete";
  static const txt_logout_message = "Are you sure to logout?";
  static const txt_card_delete_message = "Are you sure to delete this Card?";
  static const txt_delete_noti = "Are you sure to delete this Notification?";
  static const txt_attendance_success = "Attendance Marked Successfully!";
  static const txt_company_register = "Institution Registered Successfully!";
  static const txt_user_register = "User Registered Successfully!";
  static const txt_register_not_available = "Registration Form Unavailable!";
  static const txt_carddata_not_available = "Card Data Unavailable!";
  static const attendance_office_diff =
      "You are trying to scan card with different office";
  static const valid_email = "Please enter valid email";
  //static const emailerror= "Please enter email";
  /*static const txt_password = "Password";
  static const txt_passworde = "Enter password";*/
  //static var shareLink = Platform.isIOS ? iosLink : apkLink;

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

class AppFonts {
  static const primaryFont = "Montserrat";
}

var mainGrd = [AppColors.primaryColor, AppColors.secondaryColor];

class AppColors {
  static var primaryColor = fromHex("#288DCD");
  static var secondaryColor = fromHex("#116FB9");
  static var whiteColor = fromHex("#FFFFFF");
  static var darkGrayColor = fromHex("#404041");
  static var blackColor = fromHex("#000000");
  static var redColor = fromHex("#b40000");
  static var bg_reg = fromHex("#3f3f3f");
  static var bg_reg_options = fromHex("#1d1d1d");
  static var info_background = fromHex("#d9d9d9");
  static var info_background_line = fromHex("#999797");
  //static var info_background_line = fromHex("#c1c1c1");
  static var color_card_font = fromHex("#000000");
  static var color_card_border = fromHex("#e0e0e0");
  static var color_card_foreground = fromHex("#e0e0e0");
  static var color_card_background = fromHex("#ffffff");

  static var color_card_font1 = "#000000";
  static var color_card_border1 = "#e0e0e0";
  static var color_card_foreground1 = "#e0e0e0";
  static var color_card_background1 = "#ffffff";
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class AppImages {
  static const icn_logo = "assets/images/logo.png";
  static const icn_logo_card_top = "assets/images/logotop.png";
  static const pphoto_image = "assets/images/pphotoeg.png";
  static const qrcode_image = "assets/images/qrcode.png";
  static const dash_back = "assets/images/dashbg.jpg";
  static const splash_back = "assets/images/splashscreenbg.jpg";
  static const icn_logo_round = "assets/images/icn_logo_round.png";
  static const icn_contacts = "assets/images/icn_contacts.png";
  static const icn_dependent = "assets/images/icn_dependent.png";
  static const icn_placeholder = "assets/images/placeholderimage.png";
  static const icn_employment = "assets/images/icn_employment.png";
  static const icn_history_self = "assets/images/icn_history_self.png";
  static const icn_immigration = "assets/images/icn_immigration.png";
  static const icn_link = "assets/images/icn_link.png";
  static const icn_upload = "assets/images/icn_upload.png";
  static const icn_qrscan = "assets/images/qr_scan.png";
  static const icn_profile = "assets/images/icn_profile.png";
  static const ic_edit = "assets/images/ic_edit.png";
  static const browserWeb = "assets/images/browser_web.png";
  static const eyeOpen = "assets/images/eye_open.png";
  static const eyeClose = "assets/images/eye_close.png";
  static const imgreg1 = "assets/images/img11.png";
  static const imgreg2 = "assets/images/img22.png";
  static const icon_user_logo_bg = "assets/images/user_icon_bg.png";
  static const icon_user_logo = "assets/images/user_icon.png";
  //Profile

  static const changePassword =
      "assets/images/profileScreen/changePassword.png";
  static const logout = "assets/images/profileScreen/logout.png";
  static const profile = "assets/images/profileScreen/profile.png";
}

class AppLinks {
  static const citizenship = "http://www.uscis.gov/";
  static const customs = "https://i94.cbp.dhs.gov/I94/#/home";
  static const changeAddress = "https://egov.uscis.gov/coa/displayCOAForm.do";
  static const priorityDate =
      "https://travel.state.gov/content/visas/en/law-and-policy/bulletin.html";
  static const processTime = "https://egov.uscis.gov/processing-times/";
  static const docUpload = "https://i94.cbp.dhs.gov/I94/#/home";
}
