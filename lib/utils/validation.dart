
class Validation {
  static isPhoneValid(String phone) {
    final regexPhone = RegExp(r'^[0-9]+$');
    return regexPhone.hasMatch(phone) && phone.length > 9 && phone.length < 12;
  }
  static isPassValid(String pass) {
    return pass.length >= 3;
  }
  static isEmailValid(String email) {
    final regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return !regexEmail.hasMatch(email);
  }
  static checkTypePhoneEmailValid(String data) {
    if(Validation.isPhoneValid(data)){
      return "phone";
    }else if(!Validation.isEmailValid(data)){
      return "email";
    }else return "";
  }
}