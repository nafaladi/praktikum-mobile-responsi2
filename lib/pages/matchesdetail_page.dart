import 'package:flutter/material.dart';
import 'package:nafal/model/detail_matches_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../model/data_source.dart';

class MatchesDetailPage extends StatefulWidget {
  final String id;
  const MatchesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MatchesDetailPage> createState() => _MatchesDetailPageState();
}

class _MatchesDetailPageState extends State<MatchesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF56042C),
        title: Text("Match ID: ${widget.id}",
            style: TextStyle(
              color: Colors.white,
            )),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: _buildMatchesBody(),
    );
  }

  Widget _buildMatchesBody() {
    return Container(
      child: FutureBuilder(
        future: MatchesDetailDataSource.instance.loadDetail(widget.id),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            print(snapshot);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DetailMatchesModel detailModels =
                DetailMatchesModel.fromJson(snapshot.data);
            return _buildSuccessSection(detailModels);
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

  Widget _buildSuccessSection(DetailMatchesModel matches) {
    HomeTeam? home = matches.homeTeam!;
    AwayTeam? away = matches.awayTeam!;
    Statistics? homeStats = home.statistics!;
    Statistics? awayStats = away.statistics!;
    int ballPossesionHome = (homeStats.ballPossession!.round());
    int ballPossesionAway = (awayStats.ballPossession!.round());
    int passAccuracy_homeTeam = ((homeStats.passesCompleted!.toDouble() /
                homeStats.passes!.toDouble()) *
            100)
        .round();
    int passAccuracy_awayTeam = ((awayStats.passesCompleted!.toDouble() /
                awayStats.passes!.toDouble()) *
            100)
        .round();
    double ballPossesionHomeTeam = (homeStats.ballPossession!.toDouble() / 100);
    double attemptsOnGoal = ((homeStats.attemptsOnGoal!.toDouble() /
        (homeStats.attemptsOnGoal!.toDouble() +
            awayStats.attemptsOnGoal!.toDouble()) /
        1));
    double kicksOnTarget = ((homeStats.kicksOnTarget!.toDouble() /
        (homeStats.kicksOnTarget!.toDouble() +
            awayStats.kicksOnTarget!.toDouble()) /
        1));
    double corners = ((homeStats.corners!.toDouble() /
        (homeStats.corners!.toDouble() + awayStats.corners!.toDouble()) /
        1));
    double offsides = ((homeStats.offsides!.toDouble() /
        (homeStats.offsides!.toDouble() + awayStats.offsides!.toDouble()) /
        1));
    double foulsCommited = ((homeStats.foulsCommited!.toDouble() /
        (homeStats.foulsCommited!.toDouble() +
            awayStats.foulsCommited!.toDouble()) /
        1));
    double passAccuracy = ((passAccuracy_homeTeam.toDouble() /
        (passAccuracy_homeTeam.toDouble() + passAccuracy_awayTeam.toDouble()) /
        1));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
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
                      child: Row(
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
                    )),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Stadium: ${matches.venue}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Location: ${matches.location}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFF56042C),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Statistic",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Ball Possession",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: ballPossesionHomeTeam,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${ballPossesionHome}%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${ballPossesionAway}%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Shots",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: attemptsOnGoal,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${matches.homeTeam?.statistics?.attemptsOnGoal}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${matches.awayTeam?.statistics?.attemptsOnGoal}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Shot On Goal",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: kicksOnTarget,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${matches.homeTeam?.statistics?.kicksOnTarget}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${matches.awayTeam?.statistics?.kicksOnTarget}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Corners",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: corners,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${matches.homeTeam?.statistics?.corners}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${matches.awayTeam?.statistics?.corners}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Offside",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: offsides,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${matches.homeTeam?.statistics?.offsides}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${matches.awayTeam?.statistics?.offsides}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Fouls",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: foulsCommited,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${matches.homeTeam?.statistics?.foulsCommited}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${matches.awayTeam?.statistics?.foulsCommited}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Pass Accuracy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width - 60,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 30.0,
                          backgroundColor: Colors.grey,
                          barRadius: Radius.circular(50),
                          // leading: new Text("left content"),
                          // trailing: new Text("right content"),
                          percent: passAccuracy,
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "$passAccuracy_homeTeam%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "$passAccuracy_awayTeam%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          // ignore: deprecated_member_use
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Color(0xFF1077C3),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFF56042C),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Referees",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: matches.officials!.map((ofc) {
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 200,
                            width: 170,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12), // if you need this
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 80,
                                      child: const Image(
                                        image: AssetImage('assets/logo.png'),
                                      ),
                                    ),
                                    Text(
                                      "${ofc.name}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "(${ofc.role})",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
