import 'dart:convert';
import 'package:antrian_rs/tiket.dart';
import './daftar.dart';
import './poliklinik.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

class PasienLama extends StatefulWidget {
  const PasienLama({ Key? key }) : super(key: key);

  @override
  _PasienLamaState createState() => _PasienLamaState();
}

class _PasienLamaState extends State<PasienLama> {
  TextEditingController rm = TextEditingController();
  TextEditingController tgl = TextEditingController();

  void lanjut() async{
    if(rm.text ==""||tgl.text==""){
      dialogkosong();
    }
    else{
      var res = await http.post(Uri.parse("https://10.0.2.2/rs/caritiket.php"),
            body: {"rm":rm.text,});
      List l = jsonDecode(res.body);
      if(l.length<1){  
        try{
          var hasil = await http.post(Uri.parse("https://10.0.2.2/rs/carinama.php"),
            body: {"rm":rm.text,"tgl":Pasien.tgl_lahir});
          List list = jsonDecode(hasil.body);
          if(list.length<1){
            dialogdata();
          }
          else{
            setState(() {
              Pasien.nama = list[0]['nama'];
              DetailTiket.rm = rm.text;
              Daftar.jenis = false;
              Poliklinik.before =true;
              Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Poliklinik()), (Route<dynamic> route) => false);
            });
          }
        // ignore: avoid_print
        }catch(err){print(err);}
      }
      else{
        dialogdouble();
      }
    }
  }


  void kembali(){
    setState(() {
      Pasien.nama = "";
      Pasien.tempat = "";
      Pasien.tglformat = "";      
      Pasien.tgl_lahir="";
      Poliklinik.before = true;
      DetailTiket.rm ="";
    });
    Navigator.of(context)
      .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()), (Route<dynamic> route) => false);
  }


  Future<void> dialogdata() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data tidak ada'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Mohon maaf data dengan nomor rm yang anda masukkan tidak ada'),
                Text('Mohon ulangi lagi!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);                
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> dialogdouble() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data sudah ada'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Nomor RM anda sudah memiliki tiket antri yang sedang diproses'),
                Text('Silahkan mengecek pada opsi tiket di awal menu'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);                
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() { 
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  Future<void> dialogkosong() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data belum lengkap'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Mohon lengkapi data anda!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);                
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 2/4"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: kembali
          ),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff406882),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const Spacer(flex:2),
              const Text(
                "PASIEN LAMA",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
              ),
              const Spacer(flex: 1,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.85,
                child: const Text(
                  "Lengkapi identitas diri Anda untuk memudahkan petugas kami mengidentifikasi Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                    ),
                ),
              ),
              const Spacer(flex: 1,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Nomor RM",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        controller: rm,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 12
                            )
                          ),
                        )
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        controller:tgl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 12
                            )
                          ),
                        ),
                        readOnly: true,  
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(                              
                              context: context, initialDate: DateTime(2020),
                              firstDate: DateTime(1920), 
                              lastDate: DateTime.now(),
                          );                  
                          if(pickedDate != null ){
                              String formattedDate = DateFormat("EEE, d MMMM y", "id_ID").format(pickedDate); 
                              setState(() {
                                tgl.text = formattedDate;
                                Pasien.tgl_lahir = DateFormat("y-MM-d").format(pickedDate);
                              });
                          }
                        },
                      )
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffE4CDA7),
                          side: const BorderSide(width: 1,color: Colors.black),
                          elevation: 5
                        ),
                        onPressed: lanjut,
                        child: const Text(
                          "SELANJUTNYA",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          )
        ],
        
      ),
    );
  }
}