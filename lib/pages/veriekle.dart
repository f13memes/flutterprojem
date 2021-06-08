import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YaziEkrani extends StatefulWidget {
  @override
  _YaziEkraniState createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).set({
      'kullaniciid': auth.currentUser.uid,
      'baslik': t1.text,
      'icerik': t2.text
    }).whenComplete(() => print("Yazı eklendi"));
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Yazı güncellendi"));
  }

  yaziSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()['baslik'];
        gelenYaziIcerigi = gelenVeri.data()['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Veri Ekle")),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.add_chart),
                    hintText: "İlan Başlığı",
                    labelText: "İlan Başlığı",
                    border: OutlineInputBorder(),
                  ),
                  controller: t1,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.align_horizontal_left),
                    hintText: "İlan Detayları",
                    labelText: "İlan Detayları",
                    border: OutlineInputBorder(),
                  ),
                  controller: t2,
                ),
                Center(
                  child: RaisedButton(child: Text("Ekle"), onPressed: yaziEkle),
                  /* RaisedButton(
                        child: Text("Güncelle"), onPressed: yaziGuncelle),
                    RaisedButton(child: Text("Sil"), onPressed: yaziSil),
                    RaisedButton(child: Text("Getir"), onPressed: yaziGetir), */
                ),
                ListTile(
                  title: Text(gelenYaziBasligi),
                  subtitle: Text(gelenYaziIcerigi),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
