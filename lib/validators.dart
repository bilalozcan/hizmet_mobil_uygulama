import 'package:flutter/material.dart';

String repeatPasswordValidator(String repeatPassword, String password)
{
  if(repeatPassword!=password)
    return "Şifreler birbirleriyle eşleşmiyor";
  else
    return null;
}

String passwordValidator(String password) {
  if (password.length < 6)
    return "Şifrenizin 6 karakterden daha büyük olması gerekmektedir.";
  if (!password.contains(RegExp("[0-9]")) ||
      !password.contains(RegExp("[a-z]")) ||
      !password.contains(RegExp("[A-Z]")))
    return "Şifreniz en az bir sayı,bir büyük harf ve bir küçük harf içermelidir";
  return null;
}
