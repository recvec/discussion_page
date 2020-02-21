import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  int index = 0;

  PostItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("+100"),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: (){},

            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: (){},

            ),
            Text("Igor"),
            Text("20.02.2020")
          ],
        ),
        Text(
            "laurum larem lorim laurum larem lorim laurum larem lorim laurum larem lorim"),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Коментувати"),
              onPressed: (){},

            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){},

            ),
          ],
        ),
        if (index == 0)
          Padding(padding: const EdgeInsets.only(left: 40), child: PostItem(1))
      ],
    );
  }
}
