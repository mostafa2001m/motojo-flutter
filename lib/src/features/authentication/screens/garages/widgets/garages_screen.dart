// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/user_repository.dart';
import 'package:motojo/src/features/authentication/screens/garages/widgets/garages_item_widget.dart';

class GaragesScreen extends StatefulWidget {
  const GaragesScreen({super.key});

  @override
  State<GaragesScreen> createState() => _GaragesScreenState();
}

class _GaragesScreenState extends State<GaragesScreen> {
  UserRepository userRepository = UserRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Garages',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        
          
        
      ),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.white], // Add your desired colors
          stops: [0.0, 0.3],
        ),
      ),
        child: FutureBuilder<List<UserModel>>(
          future: userRepository.getUsersByAccountType(), // Replace with your desired account type
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No Garages available.'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // You can adjust the number of columns as needed
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GaragesItem(user: snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
      
      
//       GridView(
//         padding: EdgeInsets.all(10),
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 200,
//           childAspectRatio: 7/8,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         children:[
//           GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss'),
//           GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
// ,          GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
// ,          GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
//  ,         GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
//   ,        GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
//    ,       GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')
//     ,      GaragesItem(title: 'Honda', imageUrl: 'https://cdn.visordown.com/styles/amp_1200/s3/field/image/5%20%281%29.jpeg?itok=v-z5aeE5', id: 'ss')

//         ]
//       ),
    );
  }
}