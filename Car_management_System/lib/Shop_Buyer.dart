import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login.dart';
import 'product_list.dart';
class shop_buyer extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async=> false,
        child: new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text('Order',style: TextStyle(color: Colors.white),
        ),
        shape: Border(bottom:BorderSide(color: Colors.grey.shade300)
        ),
        actions: <Widget>[

        ],



      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Column(
                  children: [

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Productlist(),

          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Delivery System',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),

                );
              },

            ),
          ],
        ),
      ),

    ),);



  }

}