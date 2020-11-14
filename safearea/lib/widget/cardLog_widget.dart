import 'package:flutter/material.dart';
import 'package:safearea/models/logs_model.dart';

class CardLog extends StatelessWidget {
  final LogsModel logsModel;
  const CardLog({Key key,this.logsModel}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
        height: 120.0,
        /*margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 10.0,
        ),*/
        margin: const EdgeInsets.only(
          /*left: 10,
          right: 10,*/
          bottom: 16
        ),
        child: new Stack(
          children: <Widget>[
            bodyCard(context,logsModel),
            image,
          ],
        )
      ),
      onTap: () {},
    );
  }
}

final image = Container(
    margin: EdgeInsets.symmetric(
       vertical: 16.0,
       horizontal: 10
     ),
     alignment: FractionalOffset.centerLeft,
     child: Image(
       image: AssetImage("assets/area.png"),
      height: 92.0,
       width: 92.0,
    ),
);

 Widget bodyCard(BuildContext context, LogsModel logs) => Container(
    height: 124.0,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(left: 46.0),
    padding: EdgeInsets.only(left:60),
    decoration: BoxDecoration(
      color: Color(0xFFA64884),
      /*gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [Color(0xff3DA6AB),Color(0xFFA64884)]
              ),*/
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
       BoxShadow(  
          color: Colors.black12,
          blurRadius: 10.0,
          offset: Offset(0.0, 10.0),
        )
      ],
    ),
  
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(height: 10),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Text(logs.record.toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
             Expanded(child: SizedBox()),
             Icon(Icons.directions_walk,color: Colors.white),
             //Text(": "+logs.objetos.toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
             //SizedBox(width: 10),
             //Icon(Icons.filter_center_focus,color: Colors.green),
             //Text(": "+logs.objetos.toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
             SizedBox(width: 20)
           ],
         ),
         Text(logs.description,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
         SizedBox(height: 20),
         Text(logs.date,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold))
      ],
    ),
  );