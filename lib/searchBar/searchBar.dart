import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lynight/searchBar/searchService.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String inputSearch;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            color: Colors.transparent,
            child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).accentColor
                  )
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor,
                  ),
                  title: TextField(
                    onChanged: (val) {
                      initiateSearch(val);
                      inputSearch = val;
                    },
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Turn up",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.5),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: tempSearchStore.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.transparent,
                              elevation: 12.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Theme.of(context).accentColor,
                                            Theme.of(context).primaryColor,
                                          ]),
                                      //color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 5.0,
                                        bottom: 5),
                                    child: Column(children: [
                                      ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100.0),
                                          child: Container(
                                            padding: EdgeInsets.only(top: 2.0),
                                            width: 60.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('assets/nightClub.jpg'),
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                        ),
                                        title: Text(
                                            tempSearchStore[index]['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        subtitle: Row(children: <Widget>[
                                          Icon(
                                            Icons.music_note,
                                            color: Colors.blue,
                                          ),
                                          Text(tempSearchStore[index]['music'].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0)),
                                        ]),
                                        trailing: Icon(Icons.arrow_forward_ios,
                                            color: Colors.white),
                                      ),
                                    ]),
                                  )),
                            );
                          }))),
            ]),
          ),
        ));
  }
}
