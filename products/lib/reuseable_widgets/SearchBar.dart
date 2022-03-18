import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchBar();
  }
}

class _SearchBar extends State<SearchBar> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: Padding(
        child: Row(
          children: [
            Icon(
              Icons.search_sharp,
              color: Colors.grey,
              size: 30,
            ),

            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.grey.withOpacity(0.5),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.none),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // focusedBorder: InputBorder.none,
                        // enabledBorder: InputBorder.none,
                        // errorBorder: InputBorder.none,
                        // disabledBorder: InputBorder.none,
                        //  contentPadding: EdgeInsets.only(bottom: 18),
                        hintText: "enter your car model, make",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.withOpacity(1),
                            fontSize: 16,
                            decoration: TextDecoration.none)),
                  )

                  //   TextField(
                  //   controller: textEditingController,

                  // ),
                  ),
            )
            // TextField(
            // controller: textEditingController,
            // onSubmitted: (String value) async {
            //
            //
            //
            // }),
          ],
        ),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
