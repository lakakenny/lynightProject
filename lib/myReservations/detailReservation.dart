import 'package:flutter/material.dart';
import 'package:lynight/myReservations/myReservation.dart';
import 'package:lynight/myReservations/reservation.dart';


class DetailPage extends StatelessWidget{
  final Reservation reservation;

  DetailPage({Key key, this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.date_range,
                color: Colors.white,
                size: 25.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.0, top: 2.0),
                child : Text(
                reservation.date,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              ),
            ],
          ),
        ),
        Container(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          reservation.title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 35.0),
        ),
        SizedBox(height: 30.0),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/nightClub.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],

    );

    final readButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("QR Code maggl", style: TextStyle(color: Colors.white)),
        ));

    final bottomContentText = Text(
      'QR Code',
      style: TextStyle(fontSize: 18.0),
    );

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );




    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

}

