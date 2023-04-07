import 'package:bakerstreet_assignment/helper/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bakerstreet_assignment/model/personData.dart';
import 'package:bakerstreet_assignment/provider/genderProvider.dart';
import 'package:bakerstreet_assignment/provider/phoneAuthProvider.dart';
import 'package:bakerstreet_assignment/widgets/outputDataTextFieldWidget.dart';
import 'package:bakerstreet_assignment/widgets/textFieldlabelWidget.dart';
import '../provider/formProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _nameTextEditingController = TextEditingController();
  final _ageTextEditingController = TextEditingController();

  int selectedAge = 0;
  String _name = "";
  String _email = "";
  final String _selectedGender = '';
  DateTime _selectedDate = DateTime.now();

  var futureData;
  var _formProvider;
  final myProvider = FormProvider();
  final _nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  String calculateAge(DateTime date) {
    if (date == null) return "";
    int age = DateTime.now().difference(date).inDays ~/ 365;
    return age.toString();
  }

  @override
  void initState() {
    super.initState();
    futureData = myProvider.getUserDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _ageTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    PhoneProvider _phoneProvider = Provider.of<PhoneProvider>(context);
    GenderProvider _genderProvider = Provider.of<GenderProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => myProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Form",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        _phoneProvider.signOut();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white),
                        child: Image.asset(
                          "assets/png/logout.png",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLableWidget(title: "Name"),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                            controller: _nameTextEditingController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (name) {
                              if (name!.isEmpty) {
                                return 'Please enter your name';
                              }
                              if (!_nameRegExp.hasMatch(name)) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            onSaved: (name) {
                              _name = name!;
                            },
                            autofillHints: const [AutofillHints.name],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2.0)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              focusColor: Colors.black,
                              errorStyle: TextStyle(height: 1),
                              labelStyle: TextStyle(fontFamily: "Circular"),
                            )),
                      ),
                      TextFieldLableWidget(title: "Email"),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                            controller: _emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a Valid Email'
                                    : null,
                            onSaved: (email) {
                              _email = email!;
                            },
                            autofillHints: [AutofillHints.email],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2.0)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              focusColor: Colors.black,
                              errorStyle: TextStyle(height: 1),
                              labelStyle: TextStyle(fontFamily: "Circular"),
                            )),
                      ),
                      TextFieldLableWidget(title: "Age"),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    _selectedDate = date;
                                  });
                                }
                              });
                            },
                            readOnly: true,
                            controller: TextEditingController(
                              text: _selectedDate == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate),
                            ),
                            validator: (age) {
                              age = calculateAge(DateTime.parse(age!));
                              if (age == "") {
                                return 'Please Pick Age:';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2.0)),
                              prefixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
                              focusColor: Colors.black,
                              errorStyle: TextStyle(height: 1),
                              labelStyle: TextStyle(fontFamily: "Circular"),
                            )),
                      ),
                      const SizedBox(height: 20),
                      TextFieldLableWidget(title: "Gender"),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 'male',
                                groupValue: _genderProvider.selectedGender,
                                onChanged: (value) {
                                  Provider.of<GenderProvider>(context,
                                          listen: false)
                                      .selectGender(value!);
                                },
                              ),
                              Image.asset("assets/png/boy.png",
                                  height: 35, width: 35),
                              const SizedBox(width: 3),
                              Text(
                                'Male',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Radio(
                                value: 'female',
                                groupValue: _genderProvider.selectedGender,
                                onChanged: (value) {
                                  Provider.of<GenderProvider>(context,
                                          listen: false)
                                      .selectGender(value!);
                                },
                              ),
                              Image.asset("assets/png/girl.png",
                                  height: 35, width: 35),
                              const SizedBox(width: 3),
                              Text(
                                'Female',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: _formProvider.isLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : GestureDetector(
                                onTap: () {
                                  selectedAge =
                                      int.parse(calculateAge(_selectedDate));

                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    final user = UserData(
                                      name: _name.trim(),
                                      age: selectedAge,
                                      dob: _selectedDate.toString(),
                                      gender: _selectedGender,
                                      email: _email.trim(),
                                    );
                                    _formProvider.addUserDetails(user);
                                    _formKey.currentState?.reset();
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: yellow,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      futureData == null
                          ? Container()
                          : FutureBuilder<UserData>(
                              future: futureData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: lightPink,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  );
                                } else {
                                  final userProfile = snapshot.data!;
                                  _nameTextEditingController.text =
                                      userProfile.name;
                                  _emailTextEditingController.text =
                                      userProfile.email;
                                  _selectedDate =
                                      DateTime.parse(userProfile.dob);
                                  _genderProvider
                                      .selectGender(userProfile.gender);
                                  return Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: lightPink,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: OutputDataTextWidget(
                                        name: userProfile.name,
                                        email: userProfile.email,
                                        age: userProfile.age,
                                        dob: userProfile.dob,
                                        gender: userProfile.gender),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
