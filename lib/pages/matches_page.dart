import 'package:nafal/pages/matchesdetail_page.dart';
import 'package:nafal/model/matches_model.dart';
import 'package:nafal/providers/base_network.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMatchesBody(),
    );
  }

  Widget _buildMatchesBody() {
    return Container(
      child: FutureBuilder(
        future: BaseNetwork.getList('matches'),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            print(snapshot);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            return _buildSuccessSection(snapshot.data);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> matches) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 49,
          itemBuilder: (BuildContext context, int index) {
            MatchesModel matchesModel = MatchesModel.fromJson(matches[index]);
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return MatchesDetailPage(id: matchesModel.id.toString());
                })));
              },
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: itemCard(matchesModel),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget itemCard(MatchesModel matches) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.network(
                        "https://countryflagsapi.com/png/${matches.homeTeam?.name}",
                        height: 65,
                        width: 100,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${matches.homeTeam?.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "${matches.homeTeam?.goals} - ${matches.awayTeam?.goals}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Image.network(
                        "https://countryflagsapi.com/png/${matches.awayTeam?.name}",
                        height: 65,
                        width: 100,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${matches.awayTeam?.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
