import 'package:abdar/const/consts.dart';
import 'package:abdar/controllers/home_controller.dart';
import 'package:abdar/views/cart_screen/cart_screen.dart';
import 'package:abdar/views/categories_screen/categories_screen.dart';
import 'package:abdar/views/home/home_screen.dart';
import 'package:abdar/views/profile_screen/profile_screen.dart';
import 'package:abdar/widgets/exit_dialog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,color: Colors.white,),label: home,),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,color: Colors.white),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,color: Colors.white),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,color: Colors.white),label: account),
    ];

    var navBody =
        [
          const HomeScreen(),
          const CategoriesScreen(),
          const CartScreen(),
          const ProfileScreen()
        ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) {
          return exitDialog(context);
        },);
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(child: Container(
              child: navBody.elementAt(controller.currentNavIndex.value),
            )))
          ]
        ),
        bottomNavigationBar: Obx(()=> BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              showUnselectedLabels: false,
              backgroundColor: semiBlackColor,
              selectedItemColor: colorC,
              selectedLabelStyle: const TextStyle(
                fontFamily: semibold,
              ),
              type: BottomNavigationBarType.fixed,
              items: navbarItem,
            onTap: ((value) {
              controller.currentNavIndex.value = value;
            }),
            ),
        ),
      ),
    );
  }
}
