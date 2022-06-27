import 'package:eat_project/custom/size_config.dart';
import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieProvider? _movieProvider;

  final _valueList = ['세븐일레븐 고대2호점'];

  var _selectedValue = '세븐일레븐 고대2호점';

  Widget _makeMovieOne(Movie movie, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          //print(movie.title);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     '/deatil_product', (Route<dynamic> route) => false,
          //     arguments: movie);
          Navigator.pushNamed(context, '/deatil_product', arguments: movie);
        },
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  movie.posterUrl,
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    movie.s_name.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      "현재 주문수 " + movie.s_cnt.toString() + " 개",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _makeListView(List<Movie> movies) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.gps_fixed),
              Text(
                "픽업장소",
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(width: 15),
              DropdownButton(
                  value: _selectedValue,
                  items: _valueList.map((String item) {
                    return DropdownMenuItem(
                      child: Text(
                        item.toString(),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      value: item.toString(),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value.toString();
                      SUser.location = _selectedValue;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: _makeMovieOne(movies[index], context),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        //ターゲットデバイスの解像度を設定
        designSize: Size(375, 812),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider!.loadMovies();

    SizeConfig().init(context);

    SUser.flag = 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // disable back button
        title: Text("잇때다"),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, widget) {
          if (provider.movies != null && provider.movies.length > 0) {
            return _makeListView(provider.movies);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
