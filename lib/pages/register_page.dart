import 'package:flutter/material.dart';
import 'package:nafal/services/register_services.dart';
import 'package:nafal/pages/login_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required String title}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrangeAccent,
      //   automaticallyImplyLeading: false,
      //   title: Text(""),
      // ),
      body: Stack(
        children: [
          // Image.asset("assets/bg.png", width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: Text("Nama"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        label: Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (emailController.text.isEmpty) {
                          //tampilin snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Email tidak boleh kosong"),
                            ),
                          );
                        } else if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Nama tidak boleh kosong"),
                            ),
                          );
                        } else if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password tidak boleh kosong"),
                            ),
                          );
                        } else {
                          var result = await RegisterServices().register(
                              nameController.text,
                              emailController.text,
                              passwordController.text);

                          if (result != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registrasi Berhasil"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Email sudah dipakai"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Sign up"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return Login();
                          }),
                        );
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
