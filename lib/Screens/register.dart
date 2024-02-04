import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:machine_test/Screens/RegistrationDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var patientList;

@override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }


//Patients list

Future<void> fetchData() async {
  try {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var token = spref.getString('token');
    final response = await get(
      Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      
      final Map<String, dynamic> data = json.decode(response.body);
      // Assuming the API response structure has a key for the list, e.g., "patients"
    
        setState(() {
          patientList = data['patients'];
        });
      print(patientList);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e.toString());
    // Handle exceptions or show an error message
  }
}




    String? _selectedItem;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              patientList==null?Text('No Data Available',style: GoogleFonts.poppins(fontSize: 15),):
              Column(
                children: [
                  // Your existing UI elements in the body
              
                  // Add a search field and search button in the same row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          // controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search for treatments',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0), // Add some space between the search field and button
                      InkWell(
                        onTap: () {
                          // Handle search button press
                          // You can use the value of _searchController.text for searching
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: const Color.fromARGB(255, 15, 150, 19),),
                          
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 12),
                            child: Text('Search'),
                          )),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sort By',style: GoogleFonts.poppins(fontSize: 18),),
                      Container(
                        width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      items: ['Item 1', 'Item 2', 'Item 3']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                    child: Divider(),
                  ),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return  Card(
                        color: Color.fromARGB(255, 249, 247, 247),
                        child: ListTile(
                          title: Text('Vikram Sing',style: GoogleFonts.poppins(fontSize: 15),),
                          subtitle: Column(
                            children: [
                              Column(
                                children: [
                                  Text('Couple Combo Package (Rejuven...',style: GoogleFonts.poppins(fontSize: 15),),
                             
                              Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  Text('31/10/2024'),
                                    Icon(Icons.person),
                                  Text('Jithesh')
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('View bookings'),
                                  Icon(Icons.arrow_right_alt)
                                ],
                              )
                           ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                  ),
              
                  
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
                          color: Color.fromARGB(255, 21, 128, 24)),
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
          ),
        ),
      ),

    );
  }
}