import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import '../model/sample.dart';

class Userinfoscreen extends HookWidget {
  const Userinfoscreen({super.key});

  _submitHandler(BuildContext context) async {
    print('submittttttttttttttt');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userData = useState<User?>(null);
    var dataUser;

    _printValue() {
      print(userData.value);
    }

    _fetchData() async {
      try {
        final url = Uri.parse(
            'http://192.168.0.106:45455/api/UserInfo/Proc_UserDisplayByApi/?user_UID=admin');

        final response = await http.get(url);

        // print(response.body[0]);

        final jsonData = json.decode(response.body);
        // dataUser = jsonData;
        // print(dataUser);
        // userData.value = jsonData;
        // print(userData.value);
        // print(jsonData['Table'][0]['user_OID']);
        // print(jsonData['Table'][0]['user_imagePicture']);

        User user = parseUserFromJson(response.body);
         userData.value = user;
        // dataUser = user;
        // print(dataUser.userFullName);
        // print("Hello");
        // print(user.userFullName);
        // print(user.userOID);
        // print(user.userImagePicture);
      } catch (e) {}
    }

    useEffect(() {
      print('fffffffffffffffffffffffffffffffffffffffffffffff');

      _fetchData();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info Edit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 15,
          interactive: true,
          radius: Radius.circular(20),
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 15, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/person.png',
                      ),
                    ],
                  ),
                  textFeild(provider.user_id, "User Id"),
                  textFeild(provider.user_pass, "Password"),
                  textFeild(userData.value!.userFullName, "Full Name"),
                  textFeild(userData.value!.userDesignation, "Designation"),
                  textFeild(userData.value!.userMobileNo, "Mobile no."),
                  textFeild(userData.value!.userEmail, "Email"),
                  textFeild(userData.value!.userDepartment, "Department Code"),
                  textFeild(userData.value!.userDepartment, "Department Name"),
                  textFeild("Branch Code", "Branch Code"),
                  textFeild(userData.value!.userBrnName, "Branch Name"),
                  Image.asset(
                    'assets/images/sign.png',
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 3,
                                maximumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              onPressed: () => {_printValue()},
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .020),
                              ))),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 3,
                              maximumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            onPressed: () =>
                                {Navigator.pop(context, '/salesmgt')},
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .020),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFeild(String hint, String title) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: hint, enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
