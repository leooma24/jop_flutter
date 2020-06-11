import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/favorite_place_model.dart';
import 'package:jop/src/widgets/app_bar_bottom.dart';
import 'package:jop/src/widgets/app_bar_main.dart';
import 'package:jop/src/widgets/populares_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {       
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: AppBarMain(),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                )

              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: TextField(                        
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6.0),
                          border: InputBorder.none,
                          prefixIcon: Icon( Icons.search, color: Colors.black87),
                          hintText: "Busca lo que más se te antoje",                          
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Populares()
          ]   
        ),
      ),                
      bottomNavigationBar: AppBarBottom()
    );
  }

}