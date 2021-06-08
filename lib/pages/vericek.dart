import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listele extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listele"), actions: <Widget>[]),
      body: Container(
        child: TumYazilar(),
      ),
    );
  }
}

class TumYazilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference veriler =
        FirebaseFirestore.instance.collection('Yazilar');

    return StreamBuilder<QuerySnapshot>(
      stream: veriler.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Bir şeyler Yanlış Gitti.');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Yükleniyor...");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['baslik']),
              subtitle: new Text(document.data()['icerik']),
            );
          }).toList(),
        );
      },
    );
  }
}
