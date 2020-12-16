/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/mainFdu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';

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
  String _email;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Şifre Sıfırlama"),
          centerTitle: true,
        ),
        body: Container(color: Colors.greenAccent,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [emailWritingStage()],
        )));
  }

  Widget emailWritingStage() {
    return Column(
      children: [Text("Şifresini unuttuğunuz hesabın e-posta adresini giriniz "),
        Form(
          key: formKey,
          child: TextFormField(
            decoration: InputDecoration(
                labelText: "E-posta adresi", border: OutlineInputBorder()),
            onSaved: (email) {
              setState(() {
                this._email = email;
              });
            },
          ),
        ),
        CupertinoButton(
          child: Text("Devam"),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              collection.get().then((value) {
                for (int i = 0; i < value.size; ++i)
                  if (value.docs[i]["email"] == this._email)
                    firebaseAuth.sendPasswordResetEmail(email: this._email);
              });
              showToast(
                  context,
                  "Şifre yenileme bağlantısı $_email adresine gönderilmiştir",
                  Colors.green);
            }
          },
        )
      ],
    );
  }
}
*/