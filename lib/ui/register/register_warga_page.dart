import 'package:boilerplate/ui/login/login_warga_page.dart';
import 'package:boilerplate/ui/maps/pick_point_warga_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../../data/service/auth_service.dart';

class RegisterWargaPage extends StatefulWidget {
  final String? location;
  final double? lat;
  final double? long;
  const RegisterWargaPage({Key? key, this.location, this.lat, this.long})
      : super(key: key);

  @override
  State<RegisterWargaPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterWargaPage> {
  static final TextEditingController _instansiController =
      new TextEditingController();
  static final TextEditingController _penanggungJawabController =
      new TextEditingController();
  static final TextEditingController _emailController =
      new TextEditingController();
  static final TextEditingController _telpController =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  static final TextEditingController _jarakPengambilanControler =
      new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey();
  final _auth = AuthService();
  bool isHidePassword = true;

 

  void _togglePasswordVisibility() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _locationController =
        new TextEditingController(text: widget.location);
    return Provider<AuthService>(
      create: (_) => AuthService(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              //create form with border
              Container(
                padding: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //create email field
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Nama Instansi",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _instansiController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama Instansi Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.business,
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
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Penanggung Jawab",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _penanggungJawabController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama Penanggung Jawab Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
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

                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "No.Telp",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _telpController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'No. Telp harus diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
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
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
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
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHidePassword = !isHidePassword;
                                });
                              },
                              child: Icon(
                                isHidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
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
                          obscureText: isHidePassword,
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Jarak Pengambilan Sampah",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _jarakPengambilanControler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
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
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Alamat pengambilan",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        widget.location == null
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              content: Builder(
                                                builder: (context) {
                                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                  var height =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height;
                                                  var width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;

                                                  return Container(
                                                      width: width,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          //Pick point google map
                                                          SizedBox(height: 15),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
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
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                OutlinedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => PickPointWargaPage()));
                                                                    },
                                                                    child: Text(
                                                                      "Pilih Lokasi",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .green,
                                                                      side:
                                                                          BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                    )),
                                                          ),
                                                          SizedBox(
                                                              height: 15.0),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    RaisedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
                                                                  child: Text(
                                                                      "Submit"),
                                                                  color: Colors
                                                                      .green,
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
                                        side: BorderSide(
                                            color: Colors.green, width: 2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
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
                        SizedBox(height: 35),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () async {
                                final String namaInstansi =
                                    _instansiController.text.trim();
                                final String penanggungJawab =
                                    _penanggungJawabController.text.trim();
                                final String alamat =
                                    _locationController.text.trim();
                                final String email =
                                    _emailController.text.trim();
                                final String password =
                                    _passwordController.text.trim();
                                final String jarakPengambilan =
                                    _jarakPengambilanControler.text.trim();
                                final String telp = _telpController.text.trim();
                                final double? latitude = widget.lat;
                                final double? longitude = widget.long;
                                if (_formKey.currentState!.validate()) {}

                                if (namaInstansi.isEmpty) {
                                  print("Nama Lengkap kosong");
                                } else if (penanggungJawab.isEmpty) {
                                  print("Penanggung Jawab kosong");
                                } else if (alamat.isEmpty) {
                                  print("Alamat kosong");
                                } else if (email.isEmpty) {
                                  print("Email kosong");
                                } else if (password.isEmpty) {
                                  print("Password kosong");
                                } else if (telp.isEmpty) {
                                  print("No. Telp kosong");
                                } else if (jarakPengambilan.isEmpty) {
                                  print("Jarak Pengambilan Sampah kosong");
                                } else {
                                  _instansiController.clear();
                                  _penanggungJawabController.clear();
                                  _locationController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _jarakPengambilanControler.clear();
                                  _telpController.clear();

                                  context
                                      .read<AuthService>()
                                      .registerWarga(
                                          namaInstansi,
                                          penanggungJawab,
                                          email,
                                          password,
                                          alamat,
                                          telp,
                                          jarakPengambilan,
                                          latitude,
                                          longitude)
                                      .then((value) async {
                                    if (value == "Registration Successfully") {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginWargaPage()));
                                    }
                                  });
                                  // successful login notification
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                              )),
                        ),
                        SizedBox(height: 15),
                        Container(
                          //create hyperlink already have an account
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginWargaPage()));
                                      },
                                  ),
                                ])),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
