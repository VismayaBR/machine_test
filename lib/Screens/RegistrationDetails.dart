import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
//controllers

  @override
  void initState() {
    fetchBranchList();
    fetchTreatmentList();
    countController.text = count.toString();
     countController1.text = count1.toString();
    // TODO: implement initState
    super.initState();
  }
var countController = TextEditingController();
var countController1 = TextEditingController();
  var email = TextEditingController();
  var whatsappnumber = TextEditingController();
  var address = TextEditingController();
  var location = TextEditingController();
  var branch = TextEditingController();
  var total = TextEditingController();
  var advance = TextEditingController();

  String? _selectedOption;
  String? selectedLocation;
  String? selectedBranch;
  List<Map<String, dynamic>> branches = [];
  String? selectedTreatments;
  List<Map<String, dynamic>> treatmnet = [];

  Future<void> fetchBranchList() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var token = spref.getString('token');

    try {
      final response = await get(
        Uri.parse('https://flutter-amr.noviindus.in/api/BranchList'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // print('------------branches');
        final data = json.decode(response.body);
        print(data);
        if (data is Map<String, dynamic> && data.containsKey('branches')) {
          setState(() {
            branches = List<Map<String, dynamic>>.from(data['branches']);
          });
        } else {
          // Handle unexpected API response format
          print('Unexpected API response format');
        }
      } else {
        // Handle HTTP error
        print(
            'Failed to load branch list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network issues
      print('Error during API request: $e');
    }
  }

   int count = 0;

  void increment() {
    setState(() {
      count++;
       countController.text = count.toString();
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
         countController.text = count.toString();

      });
    }
  }

 int count1 = 0;

  void increment1() {
    setState(() {
      count1++;
       countController1.text = count1.toString();
    });
  }

  void decrement1() {
    if (count1 > 0) {
      setState(() {
        count1--;
         countController1.text = count1.toString();

      });
    }
  }


 Future<void> fetchTreatmentList() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var token = spref.getString('token');

    try {
      final response = await get(
        Uri.parse('https://flutter-amr.noviindus.in/api/TreatmentList'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
      
        // print('------------branches');
        final data = json.decode(response.body);
        print('-------------------------$data');
        if (data is Map<String, dynamic> && data.containsKey('treatments')) {
          print('object');
          setState(() {
            treatmnet = List<Map<String, dynamic>>.from(data['treatments']);
          });
          print(treatmnet);
        } else {
          // Handle unexpected API response format
          print('Unexpected API response format');
        }
      } else {
        // Handle HTTP error
        print(
            'Failed to load branch list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network issues
      print('Error during API request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Icon(Icons.notifications_active),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Register',
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Email',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                          color: Color.fromARGB(
                              255, 227, 226, 226)), // Change border color here
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Whatsapp number',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                          color: Color.fromARGB(
                              255, 227, 226, 226)), // Change border color here
                    ),
                    child: TextFormField(
                      controller: whatsappnumber,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Address',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                          color: Color.fromARGB(
                              255, 227, 226, 226)), // Change border color here
                    ),
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Location',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 241, 241),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(
                        color: Color.fromARGB(
                            255, 227, 226, 226)), // Change border color here
                  ),
                  child: DropdownButtonFormField<String>(
                    value:
                        selectedLocation, // You need to have a variable to store the selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue;
                      });
                    },
                    items: ['Location 1', 'Location 2', 'Location 3']
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder
                          .none, // Remove the underline in normal state
                      focusedBorder: InputBorder
                          .none, // Remove the underline in focused state
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Branch',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 241, 241),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: Color.fromARGB(255, 227, 226, 226)),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedBranch,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBranch = newValue;
                      });
                    },
                    items: branches
                        .map<DropdownMenuItem<String>>(
                          (branch) => DropdownMenuItem<String>(
                            value: branch['name'],
                            child: Text(branch['name']),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Treatments',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 222, 216, 216),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1. Couple Combo package i..',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Male  ',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(255, 243, 241, 241),
                                    borderRadius: BorderRadius.circular(
                                        5), // Rounded corners
                                    border: Border.all(
                                        color: Color.fromARGB(255, 175, 172,
                                            172)), // Change border color here
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Female  ',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(255, 243, 241, 241),
                                    borderRadius: BorderRadius.circular(
                                        5), // Rounded corners
                                    border: Border.all(
                                        color: Color.fromARGB(255, 175, 172,
                                            172)), // Change border color here
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // height: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: InkWell(
                  onTap: () {
                    _showMyDialog(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 189, 218, 190)),
                    height: 60,
                    child: Center(
                        child: Text(
                      '+Add Treatment',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Total Amount',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                          color: Color.fromARGB(
                              255, 227, 226, 226)), // Change border color here
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Discount Amount',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 26),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                          color: Color.fromARGB(
                              255, 227, 226, 226)), // Change border color here
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, right: 26, bottom: 15, top: 15),
                    child: Text(
                      'Payment Option',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildRadioButton(
                      'Cash',
                    ),
                    buildRadioButton('Card'),
                    buildRadioButton('Upi'),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget buildRadioButton(String label) {
    return Row(
      children: [
        Radio(
          value: label,
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value;
            });
          },
        ),
        Text(label,
            style: GoogleFonts.poppins(
              fontSize: 15,
            )),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Choose Treatment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Color.fromARGB(255, 227, 226, 226)),
                    ),
                    child: SizedBox(
                      
                      child: DropdownButtonFormField<String>(
                        value: selectedTreatments,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTreatments = newValue;
                          });
                        },
                        items: treatmnet
                            .map<DropdownMenuItem<String>>(
                              (treatmnet) => DropdownMenuItem<String>(
                                value: treatmnet['name'],
                                child: Text(treatmnet['name']),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Add Patients',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Male',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                       Container(
                         
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 9, 105, 12),
                              
                              ),
                              child:Center(child: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){
                                increment1();
                              },))),
                                Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: countController1,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                               Container(
                         
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 9, 105, 12),
                              
                              ),
                              child:Center(child: IconButton(icon: Icon(Icons.remove,color: Colors.white,),onPressed: (){
                                decrement1();
                              },)))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                            
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Female',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                       Container(
                         
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 9, 105, 12),
                              
                              ),
                              child:Center(child: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){
                                increment();
                              },))),
                                Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: countController,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                            
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                               Container(
                         
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 9, 105, 12),
                              
                              ),
                              child:Center(child: IconButton(icon: Icon(Icons.remove,color: Colors.white,),onPressed: (){
                                decrement();
                              },)))
                      ],
                    ),
                     Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: InkWell(
                    onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context) {
                       return Details();
                     },));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 12, 108, 16)),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Register Now',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        
        );
      },
    );
  }
}
