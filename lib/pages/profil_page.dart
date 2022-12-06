import 'package:flutter/material.dart';
// import 'package:nafal/pages/logout_page.dart';

// import 'logout.dart';
class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          ListTile(
                              subtitle: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Profil',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  height: 200,
                                                  child: Image(
                                                      image: AssetImage(
                                                          'assets/nafal.jpg'))),
                                              Column(
                                                children: <Widget>[
                                                  ...ListTile.divideTiles(
                                                    color: Colors.grey,
                                                    tiles: [
                                                      ListTile(
                                                        title: Text(
                                                            "Nama: Nafal Adi SL"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  ...ListTile.divideTiles(
                                                    color: Colors.grey,
                                                    tiles: [
                                                      ListTile(
                                                        title: Text(
                                                            "NIM: 124200025"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  ...ListTile.divideTiles(
                                                    color: Colors.grey,
                                                    tiles: [
                                                      ListTile(
                                                        title: Text(
                                                            "TTL: Cilacap, 22 September 2022"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  ...ListTile.divideTiles(
                                                    color: Colors.grey,
                                                    tiles: [
                                                      ListTile(
                                                        title: Text(
                                                            "Hobi: Bermain Game"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   style: TextButton.styleFrom(
                  //       backgroundColor: Color(0xffF18265)),
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (context) {
                  //         return const Logout();
                  //       }),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'Logout',
                  //     style: TextStyle(
                  //         // fontWeight: FontWeight.bold,
                  //         ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
