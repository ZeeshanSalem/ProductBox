import 'package:f2_base_project/core/others/localization_class.dart';
import 'package:f2_base_project/ui/screens/cart/cart_screen_view_model.dart';
import 'package:f2_base_project/ui/screens/items/items_list.dart';
import 'package:f2_base_project/ui/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/models/cart.dart';
import 'locator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter<Cart>(CartAdapter());
//  await Hive.openBox<Cart>('cart');
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 810),
       builder:()=> MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (context) => CartViewModel()),
         ],
         child: GetMaterialApp(
          translations: LocalizationClass(),
          locale: Locale('en'),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: RootScreen(),
      ),
       ),
    );
  }
}

