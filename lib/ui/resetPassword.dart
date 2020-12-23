

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/validators.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

/* Kullanıcının şifresini unutması halinde şifresini yenilemesi için açılan sayfa
* Kullanıcının girdiği e posta eğer sistemde varsa, kullanıcının girmiş olduğu e postaya
* şifre yenileme maili gider*/

/* !UYARI!
* Kullanıcı için yenileme maili gittiğinde kullanıcı, şifresini istediği düzende belirleyebiliyor. Bunun önüne geçebilmek için ya telefon entegrasyonu ya da güvenlik sorusu
* eklenebilir.*/

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _password = TextEditingController();
  bool _obscureText;
  var formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _obscureText=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre Sıfırlama"),
        centerTitle: true,
      ),
      body: Container(
        padding:EdgeInsets.all(MediaQuery.of(context).size.width/5),
        child: Center(
          child: Form(
            key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextFormField(
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: _showPassword(),
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
                validator: passwordValidator,

                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: _showPassword(),
                    labelText: "Şifreyi Tekrarla",
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  validator: (value){
                   return repeatPasswordValidator(value, _password.text);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),Center(child: RaisedButton(child: Text("Şifreyi Değiştir"),onPressed:updatePassword,))],
            ),
          ),
        ),
      ),
    );
  }
  Widget _showPassword() {
    return IconButton(
      icon: Icon(
          _obscureText==true?Icons.visibility_outlined:Icons.visibility_off_outlined,
          color: Colors.black
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

  void updatePassword() {
    if(formKey.currentState.validate())
      {
        try {
          UserModel _userModel = Provider.of<UserModel>(context, listen: false);
          _userModel.updatePassword(_password.text);
          showToast(context, "Şifre değiştirme başarılı", Colors.green);
          Navigator.pop(context);
        }
        catch (e)
        {
          showToast(context,e.toString(),Colors.red);
        }
      }
    else
      showToast(context,"Şifre değiştirilirken bir sorun oluştu. Lütfen tekrar deneyiniz",Colors.red);
  }
}
