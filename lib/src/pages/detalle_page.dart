import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jop/src/blocs/place_bloc.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/widgets/app_bar_bottom.dart';
import 'package:jop/src/widgets/crear_chip.dart';
import 'package:jop/src/widgets/favorite_btn.dart';

class DetallePage extends StatelessWidget {  
  const DetallePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context).settings.arguments;  
    final PlaceBlock placeStream = PlaceBlock();
    placeStream.setPlace(place.id);
    return Scaffold(
      backgroundColor: Colors.grey[100],      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearFondo(context, place),
            Transform.translate(
              offset: Offset(0.0, -76.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(16.0),
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white
                      )
                    ),
                    child: DefaultTabController(
                      length: 3,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _tabBar(),
                          _name(place),    
                          _address(place),                
                          _description(place),
                          _rating(place),
                          _promociones(place)
                        ],
                      ),                
                    ),
                  ),
                  _productos()
                ],
              ),
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: AppBarBottom(),
    );
  }

  Widget _crearFondo(BuildContext context, Place place) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * .5,            
      width: double.infinity,
      decoration: BoxDecoration (
        color: AppColors.primary,
        image: DecorationImage(
          image: place.getBanner(),
          fit: BoxFit.cover
        )
      ),
      child: SafeArea(
        child: Row(                
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.transparent,
                ),
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white ),
                  onPressed: () {
                    Navigator.pop(context);
                  },),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: FavoriteBtn(place: place)
            )
          ],
        ),
      ),         
    );
  }

  Widget _tabBar() {
    return TabBar(
      labelColor: AppColors.accent,
      indicatorColor: AppColors.accent,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 50.0),
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      unselectedLabelColor: Colors.black87,
      tabs: [
        Tab( text: 'Negocio' ),
        Tab( text: 'Menú' ),
        Tab( text: 'Reseñas' ),
      ],
    );
  }

  Widget _name(place) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),                      
      child: 
        Text(
          place.name, 
          style: TextStyle( 
            fontSize: 16.0, 
            color: Colors.black,
            fontWeight: FontWeight.w700
          )
        )
    );
  }

  Widget _address(place) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: 
        Text(place.address, style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 14.0,
          color: Colors.black87
        )
      )
    );
  }

  Widget _description( place ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: 
        Text(place.description, style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 14.0,
          color: Colors.grey
        )
      )
    );
  }

  Widget _rating( place ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),                      
      child: Row(
        children: <Widget>[
          Expanded(
            child: RatingBar(
              ignoreGestures: true,
              initialRating: place.rating ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                CrearChip(
                  width: 60.0,
                  icon: Icons.location_on,
                  texto: '${place.distance}k'),
              ],
            ),
          ),
          SizedBox(width: 5.0,),
          Container(
            child: Row(
              children: <Widget>[
                CrearChip(
                  width: 60.0,
                  icon: Icons.access_time,
                  texto: "${place.time}'")
              ],
            ),
          ),
        ],
      ),
    );                    
  }

  Widget _promociones( place ) {
    final PlaceBlock placeStream = PlaceBlock();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )
      ),                      
      child: Column(
        children: <Widget>[
          _crearPromocion(Icons.phone, place.phone),
          Divider( color: Colors.grey[300], height: 3, thickness: 1,  indent: 20, endIndent: 20, ),
          StreamBuilder<Place> (
            stream: placeStream.placeStream,
            builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
              if(snapshot.hasData) {
                return _crearPromocion(Icons.schedule , snapshot.data.getScheduleDay );
              } else {
                return Container();
              }

            },
          ),
          Divider( color: Colors.grey[300], height: 3, thickness: 1,  indent: 20, endIndent: 20, ),
          _crearPromocion(Icons.access_time, place.getOpenNow ),
          Divider( color: Colors.grey[300], height: 3, thickness: 1,  indent: 20, endIndent: 20, ),
          _crearPromocion(Icons.check, 'Envío gratis con el código msd info: "EnvioGratis"'),
          Divider( color: Colors.grey[300], height: 3, thickness: 1,  indent: 20, endIndent: 20, ),
          _crearPromocion(Icons.local_offer, '10% de descuento todos los lunes.'),
        ],
      ),
    );
                  
  }

  _crearPromocion(IconData icon, String texto) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),      
      child: Row(
        children: <Widget>[
          Container(
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: AppColors.accent
            ),
            child: 
              Icon( icon, color: Colors.white, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Column(children: <Widget>[Text(texto)],)
          
      ],),
    );
  }

  Widget _productos() {
    return Column(
      children: <Widget>[
        Divider( color: Colors.grey[300], height: 3, thickness: 1 ),
        DefaultTabController(
          length: 5,
          child: TabBar(
            labelColor: AppColors.accent,
            indicatorColor: AppColors.accent,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 50.0),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            unselectedLabelColor: Colors.black87, 
            isScrollable: true, 
            onTap: (value) {
              print('Categorias de Productos: $value');
            },              
            tabs: [
              Tab(text: 'Tortas'),
              Tab(text: 'Papas'),
              Tab(text: 'Bebidas'),
              Tab(text: 'Un nombre mas largo'),
              Tab(text: 'Bebidas'),
            ],
          ),
        ),
        Divider( color: Colors.grey[300], height: 3, thickness: 1 ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _filtros(),
              _producto(),
              Divider( color: Colors.grey[300], height: 3, thickness: 1 ),
              _producto(),
              Divider( color: Colors.grey[300], height: 3, thickness: 1 ),
              _producto(),
              Divider( color: Colors.grey[300], height: 3, thickness: 1 ),
              _producto(),          
            ],
          ),
        ),
      ],
    );
  }

  Widget _producto() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all( color: Colors.white ),
              image: DecorationImage(
                image: NetworkImage('http://192.168.1.68:8000/storage/menu/place124/phpED62.tmp.jpg'),
                fit: BoxFit.cover,
              )         
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only( left: 10.0 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Torta Especial', style: TextStyle(fontWeight: FontWeight.w700),),
                  SizedBox(height: 2.0),
                  Text('Torta de carne de cerdo con verduras', style: TextStyle(color: Colors.grey)),                  
                ],
              ),
            ),
          ),
          Text('\$65.00', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.accent, fontSize: 18.0),)
      ]),
    );
  }

  Widget _filtros() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(top: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.withOpacity(.2)
          ),
          child: Icon( Icons.sort)
        ),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.withOpacity(.2)
          ),
          child: Icon( Icons.tune)
        )
      ],
    );
  }
}