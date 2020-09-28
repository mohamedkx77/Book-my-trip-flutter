import 'package:bookmytrip/models/order_model.dart';
import 'package:bookmytrip/provider/hotel_provider.dart';
import 'package:bookmytrip/provider/order_provider.dart';
import 'package:bookmytrip/screens/hotel_directions_screen.dart';
import 'package:bookmytrip/widgets/carsoul.dart';
import 'package:bookmytrip/widgets/drawer_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelDetailsScreen extends StatefulWidget {
  static const roueId = '/hotel-details';

  @override
  _HotelDetailsScreenState createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  int _nights = 1;

  int _days = 1;

  int _rooms = 1;

  @override
  Widget build(BuildContext context) {
    final hotelId = ModalRoute.of(context).settings.arguments as String;
    final hotelProvider =
        Provider.of<HotelProvider>(context, listen: false).findById(hotelId);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      drawer: DrawerApp(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Hotel Details",
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                // color: Colors.orange,
                child: Carousel(hotelProvider.images),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hotelProvider.hotelName,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "5 star hotel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${hotelProvider.dayPrice}",
                    style: TextStyle(
                      color: Color(0xFFF57C00),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                hotelProvider.description,
                style: TextStyle(
                    height: 1.5,
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 0.7),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSmallCard(
                      title: "Nights",
                      filed: _nights,
                      add: () {
                        setState(() {
                          _nights++;
                        });
                      },
                      remove: () {
                        setState(() {
                          _nights > 1 ? _nights-- : _nights = 1;
                        });
                      }),
                  buildSmallCard(
                      title: "Days",
                      filed: _days,
                      add: () {
                        setState(() {
                          _days++;
                        });
                      },
                      remove: () {
                        setState(() {
                          _days > 1 ? _days-- : _days = 1;
                        });
                      }),
                  buildSmallCard(
                      title: "Rooms",
                      filed: _rooms,
                      add: () {
                        setState(() {
                          _rooms++;
                        });
                      },
                      remove: () {
                        setState(() {
                          _rooms > 1 ? _rooms-- : _rooms = 1;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              GestureDetector(
                onTap: () {
                  orderProvider.orders.add(
                    OrderModel(
                      hotelName: hotelProvider.hotelName,
                      price: hotelProvider.dayPrice,
                      nights: _nights,
                      days: _days,
                      rooms: _rooms,
                    ),
                  );
                  Navigator.of(context).pushNamed(HotelDirectionsScreen.routeId,
                      arguments: hotelProvider.id);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1 - 20,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Color(0xFFF57C00),
                      borderRadius: BorderRadius.circular(35)),
                  child: Text(
                    "Book Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSmallCard(
      {String title, int filed, Function remove, Function add}) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: remove,
                  child: Icon(
                    Icons.remove,
                    size: 19,
                  ),
                ),
                Text(filed.toString()),
                InkWell(
                  onTap: add,
                  child: Icon(
                    Icons.add,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
