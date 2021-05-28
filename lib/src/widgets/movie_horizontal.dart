import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  const MovieHorizontal({Key key, @required this.peliculas, @required this.siguientePagina}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
    );

    _pageController.addListener(() { 

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 300){
        siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.23,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, index) => _tarjeta(context, peliculas[index]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage( pelicula.getPosterImg() ),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    //Captura los gestos que se hacen en pantalla
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );

  }

  // List<Widget> _tarjetas(BuildContext context) {

  //   return peliculas.map((pelicula) {

  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: FadeInImage(
  //                 placeholder: AssetImage('assets/img/no-image.jpg'), 
  //                 image: NetworkImage( pelicula.getPosterImg() ),
  //                 fit: BoxFit.cover,
  //                 height: 150.0,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 5.0,),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       ),
  //     );

  //   }).toList();

  // }
}