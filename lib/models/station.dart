import 'package:dio/dio.dart';

class Station {
  final int id;
  final String name;
  final double startSnowWaterEq;
  final double changeInSnowWaterEq;
  final double startSnowDepth;
  final double changeSnowDepth;

  Station(this.name, 
        this.id, 
        this.startSnowWaterEq, 
        this.changeInSnowWaterEq, 
        this.startSnowDepth, 
        this.changeSnowDepth);


 }
 



