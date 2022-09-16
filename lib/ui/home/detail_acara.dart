import 'package:boilerplate/ui/maps/pick_point_acara.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAcara extends StatefulWidget {
  final String? location;
  final double? lat;
  final double? long;
  DetailAcara(
      {Key? key,
      required String this.location,
      required this.lat,
      required this.long})
      : super(key: key);

  @override
  State<DetailAcara> createState() => _DetailAcaraState();
}

class _DetailAcaraState extends State<DetailAcara> {
  static final TextEditingController _namaPenanggungJawab =
      new TextEditingController();
  static final TextEditingController _jenisAcara = new TextEditingController();
  static final TextEditingController _isiLaporan = new TextEditingController();
  static TextEditingController _dateInput = TextEditingController();
  static TextEditingController _timeInput = TextEditingController();
  static TextEditingController _noTelp = new TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  final GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _locationController =
        new TextEditingController(text: widget.location);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Laporan Acara',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff00783E),
            ),
            label: const Text(
              'Back',
              style: TextStyle(color: Color(0xff00783E)),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Text(
                  'Nama Penanggung Jawab',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  controller: _namaPenanggungJawab,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Harus Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.event_note,
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Text(
                  'Jenis Acara',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  controller: _jenisAcara,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jenis Harus Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.event_note,
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 15),
                child: Text(
                  'Detail Acara',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  controller: _isiLaporan,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Isi Laporan Harus Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    // prefixIcon: Icon(
                    //   Icons.description_rounded,
                    //   color: Colors.green,
                    // ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 15),
                child: Text(
                  'Tanggal Acara',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                child: TextField(
                  readOnly: true,
                  controller: _dateInput,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        Future.delayed(Duration.zero, () {
                          _dateInput.text = formattedDate;
                        }); //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  'Waktu Acara',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                child: TextField(
                  readOnly: true,
                  controller: _timeInput,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.timer,
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onTap: () async {
                    _selectTime(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 5),
                child: Text(
                  'No Telp',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  controller: _noTelp,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'No telp Harus Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.event_note,
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  'Alamat',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 15),
                child: widget.location!.isEmpty
                    ? Container(
                        height: 45,
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      content: Builder(
                                        builder: (context) {
                                          // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                          var width =
                                              MediaQuery.of(context).size.width;

                                          return Container(
                                              width: width,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  //Pick point google map
                                                  SizedBox(height: 15),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Pilih Lokasi",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    height: 45,
                                                    width: double.infinity,
                                                    child: OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PickPointAcara()));
                                                        },
                                                        child: Text(
                                                          "Pilih Lokasi",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          primary: Colors.green,
                                                          side: BorderSide(
                                                            width: 2,
                                                            color: Colors.green,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                        width: double.infinity,
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          child: Text("Submit"),
                                                          color: Colors.green,
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  10,
                                                                  10,
                                                                  10),
                                                        )),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    );
                                  });
                            },
                            style: OutlinedButton.styleFrom(
                                primary: Colors.green,
                                side: BorderSide(color: Colors.green, width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)))),
                            child: Text(
                              "Tambah Alamat",
                            )),
                      )
                    : TextFormField(
                        maxLines: 5,
                        controller: _locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Alamat Harus Diisi';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {}
                         SharedPreferences prefs = await SharedPreferences.getInstance();
  
                        //insert into firestore
                        CollectionReference lokasi =
                            FirebaseFirestore.instance.collection('lokasi');
                        CollectionReference jadwalKhusus = FirebaseFirestore
                            .instance
                            .collection('jadwal_khusus');

                        if (widget.location!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Lokasi Harus Diisi'),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          lokasi
                              .add({
                                'penanggungJawab': _namaPenanggungJawab.text,
                                'alamat': _locationController.text,
                                'lat': widget.lat,
                                'long': widget.long,
                              })
                              .then((value) => print("Lokasi Added"))
                              .catchError((error) =>
                                  print("Failed to add lokasi: $error"));
                          jadwalKhusus.add({
                            'penanggungJawab': _namaPenanggungJawab.text,
                            'jenis_acara': _jenisAcara.text,
                            'keterangan_acara': _isiLaporan.text,
                            'tanggal': _dateInput.text,
                            'waktu': _timeInput.text,
                            'no_telp': _noTelp.text,
                            'lokasi': _locationController.text,
                            'lat': widget.lat,
                            'long': widget.long,
                            'uid_akun': prefs.getString('uid'),
                            'status': false,
                            'created_at': DateTime.now(),
                            'updated_at': DateTime.now(),
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Jadwal Khusus Berhasil Ditambahkan'),
                              backgroundColor: Colors.green,
                            ));
                          }).catchError((error) =>
                              print("Failed to add jadwal khusus: $error"));
                        }

                        _namaPenanggungJawab.clear();
                        _jenisAcara.clear();
                        _isiLaporan.clear();
                        _dateInput.clear();
                        _timeInput.clear();
                        _noTelp.clear();
                        _locationController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Tambah Acara",
                      )),
                ),
              )
            ],
          ),
        )));
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        _timeInput.text = selectedTime.format(context);
      });
    }
  }
}
