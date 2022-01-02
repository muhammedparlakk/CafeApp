import 'package:cafeapp/service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMakeRezervation extends StatefulWidget {
  final String cafeId;
  final String cafename;

  UserMakeRezervation(String cafeId, String cafename)
      : this.cafeId = cafeId,
        this.cafename = cafename;

  @override
  State<UserMakeRezervation> createState() =>
      _UserMakeRezervationState(cafeId, cafename);
} //view

class _UserMakeRezervationState extends State<UserMakeRezervation> {
  _UserMakeRezervationState(this.cafeId, this.cafename);

  final String cafeId;
  final String cafename;

  Future<TimeOfDay> saatSec(BuildContext context) {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  Future<DateTime> tarihSec(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2023),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }

  TextEditingController textcontoller = TextEditingController();
  TextEditingController noteContoller = TextEditingController();
  TextEditingController peopleContoller = TextEditingController();

  DateTime secilenTarih = DateTime.now();
  TimeOfDay secilenSaat = TimeOfDay.fromDateTime(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            height: 118,
            child: Container(
              height: 29,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0), //dikkat
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        //üst boşluk
                        height: 80,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          margin: EdgeInsets.only(left: 15, top: 30),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/butonimage.png'),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),

                      SizedBox(width: 37), //boşluk

                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 30),
                        child: Text(cafename,
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30, right: 20),
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              AuthService().addRezervation(
                                  peopleContoller.text,
                                  cafeId,
                                  noteContoller.text,
                                  "Saat : ${secilenSaat.hour.toString()} : ${secilenSaat.minute.toString()}   Tarih : ${secilenTarih.day}-${secilenTarih.month}-${secilenTarih.year}",
                                  cafename);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 32,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Color(0xFF1B7CA2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Oluştur",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Rezervasyon Oluştur",
                      style: GoogleFonts.roboto(
                        color: Color(0xFF606060),
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Color(0xFFFE5E5E5),
            height: MediaQuery.of(context).size.height - 118,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(top: 22),
                  alignment: Alignment.centerLeft,
                  height: 39,
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/user_icon.png'),
                          fit: BoxFit.fill,
                        )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        color: Colors.white,
                        width: 272,

                        padding: EdgeInsets.only(left: 16),
                        //height:,
                        child: TextField(
                          controller: peopleContoller,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Kaç Kişisiniz ?",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    secilenTarih = await tarihSec(context);

                    if (secilenTarih != null) {
                      secilenSaat = await saatSec(context);
                    }

                    if (secilenTarih != null && secilenSaat != null) {
                      textcontoller.text =
                          "Saat : ${secilenSaat.hour.toString()} : ${secilenSaat.minute.toString()}   Tarih : ${secilenTarih.day}-${secilenTarih.month}-${secilenTarih.year}";
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    margin: EdgeInsets.only(top: 22),
                    alignment: Alignment.centerLeft,
                    height: 39,
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/time_icon.png'),
                            fit: BoxFit.fill,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            color: Colors.white,
                            width: 272,
                            padding: EdgeInsets.only(left: 16),
                            //height:,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Text(
                                  "Saat : ${secilenSaat.hour.toString()} : ${secilenSaat.minute.toString()}   Tarih : ${secilenTarih.day}-${secilenTarih.month}-${secilenTarih.year}"),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(top: 22),
                  alignment: Alignment.centerLeft,
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/message.png'),
                          fit: BoxFit.fill,
                        )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        color: Colors.white,
                        width: 272,
                        height: 200,
                        padding: EdgeInsets.only(left: 16),
                        //height:,
                        child: TextField(
                          controller: noteContoller,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Eklemek İstediğiniz ?",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          //Alt Contanier
        ],
      )),
    );
  }
} //view