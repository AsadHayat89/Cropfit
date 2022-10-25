import 'package:crop_fit/screens/AdminSide/admin_dashboard.dart';
import 'package:crop_fit/screens/AdminSide/admin_login.dart';
import 'package:crop_fit/screens/Complain.dart';
import 'package:crop_fit/screens/FarmerSide/cnic_uploader.dart';
import 'package:crop_fit/screens/FarmerSide/crop_registration_form.dart';
import 'package:crop_fit/screens/FarmerSide/dairy_list.dart';
import 'package:crop_fit/screens/FarmerSide/deals.dart';
import 'package:crop_fit/screens/FarmerSide/edit_profile.dart';
import 'package:crop_fit/screens/FarmerSide/farmer_splash.dart';
import 'package:crop_fit/screens/FarmerSide/fruit_list.dart';
import 'package:crop_fit/screens/FarmerSide/home.dart';
import 'package:crop_fit/screens/FarmerSide/organic_list.dart';
import 'package:crop_fit/screens/FarmerSide/phone.dart';
import 'package:crop_fit/screens/FarmerSide/profile.dart';
import 'package:crop_fit/screens/FarmerSide/submission_splash.dart';
import 'package:crop_fit/screens/FarmerSide/vegetable_list.dart';
import 'package:crop_fit/screens/FarmerSide/verify.dart';
import 'package:crop_fit/screens/InvestorSide/DetailCrops.dart';
import 'package:crop_fit/screens/InvestorSide/all.dart';
import 'package:crop_fit/screens/InvestorSide/dairy_store.dart';
import 'package:crop_fit/screens/InvestorSide/fruit_store.dart';
import 'package:crop_fit/screens/InvestorSide/notification.dart';
import 'package:crop_fit/screens/InvestorSide/crop_rfq.dart';
import 'package:crop_fit/screens/InvestorSide/dairy.dart';
import 'package:crop_fit/screens/InvestorSide/edit_profile.dart';
import 'package:crop_fit/screens/InvestorSide/farmer_profile.dart';
import 'package:crop_fit/screens/InvestorSide/fruits.dart';
import 'package:crop_fit/screens/InvestorSide/investor_splash.dart';
import 'package:crop_fit/screens/InvestorSide/organic.dart';
import 'package:crop_fit/screens/InvestorSide/organic_store.dart';
import 'package:crop_fit/screens/InvestorSide/profile.dart';
import 'package:crop_fit/screens/InvestorSide/store.dart';
import 'package:crop_fit/screens/InvestorSide/submission_splash.dart';
import 'package:crop_fit/screens/InvestorSide/vegetables.dart';
import 'package:crop_fit/screens/InvestorSide/veggies_store.dart';
import 'package:crop_fit/screens/InvestorSide/verical-croplist.dart';
import 'package:crop_fit/screens/changed_password.dart';
import 'package:crop_fit/screens/FarmerSide/notification.dart';
import 'package:crop_fit/screens/FarmerSide/crop_inquiries_details.dart';
import 'package:crop_fit/screens/feedback.dart';
import 'package:crop_fit/screens/forgot_password_screen.dart';
import 'package:crop_fit/screens/onboarding_page.dart';
import 'package:crop_fit/screens/print_contract.dart';
import 'package:crop_fit/screens/signup_screen.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/screens/login_screen.dart';
import 'package:crop_fit/screens/welcome_screen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:crop_fit/screens/FarmerSide/farmer_dashboard.dart';
import 'package:crop_fit/screens/FarmerSide/registered_crops.dart';
import 'package:get/get.dart';
import 'Location/permission_access.dart';
import 'firebase_options.dart';
import 'screens/FarmerSide/setting.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializePreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crop Fit',
      navigatorKey: appNavigationKey,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home:  const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreenPath: (context) => const LoginScreen(),
        adminLoginScreenPath:(context)=>const AdminLoginScreen(),
        adminDashboardPath:(context)=>const AdminDashboard(),
        signupScreenPath: (context) => const SignupScreen(),
        forgotPasswordScreenPath:(context)=>const ForgotPassword(),
        welcomeScreenPath: (context) => const WelcomeScreen(),
        farmerdashboardPath: (context) => const FarmerDashboard(),
        investordashboardPath:(context)=>const InvestorDashboard(),
        registeredcropsPath:(context)=>const RegisteredCrops (),
        farmerHomePath:(context)=>const FarmerHome (),
        farmerProfilePath:(context)=>const FarmerProfile (),
        investorProfilePath:(context)=>const InvestorProfile (),
        farmerSettingsPath:(context)=>const FarmerProfileSettings (),
        CropRegistrationFormPath:(context)=>const CropRegisteration(),
        FarProfilePath:(context)=>const FarmerEditProfile(),
        InvesProfilePath:(context)=>const InvestorEditProfile(),
        PageOnBorardingPath:(context)=> PageOnBorarding(),
        ComplainPath:(context)=>const Complain(),
        FamDealsPath:(context)=>const FamDeals(),
        changedPasswordPath:(context)=>const ChangedPassword(),
        MyCropPagePath:(context)=>MyCropPage(),
        DetailCropsPath:(context)=>const DetailCrops(),
        farmerSplashScreenPath:(context)=>const FamSplash(),
        farmerSubmissionSplashScreenPath:(context)=>const FarmerSubmissionSplash(),
        investorSubmissionSplashScreenPath:(context)=>const InvestorSubmissionSplash(),
        investorSplashScreenPath:(context)=>const InSplash(),
        farmerNotificationScreenPath:(context)=>const FarmerNotificationScreen(),
        cropInquiriesResponsesScreenPath:(context)=>const CropInquiriesResponsesScreen(),
        cnicUploaderScreenPath:(context)=>const CnicUploaderScreen(),
        locationScreenPath:(context)=>const LocationScreen(),
        vegetablesScreenPath:(context)=>const VegetableListScreen(),
        fruitsScreenPath:(context)=>const FruitListScreen(),
        organicScreenPath:(context)=>const OrganicListScreen(),
        dairyScreenPath:(context)=>const DairyListScreen(),
        feedbackScreenPath:(context)=>const FeedbackScreen(),
        vegetablesCardScreenPath:(context)=>VegetablesCardScreen(dataList: [],),
        fruitsCardScreenPath:(context)=>const FruitsCardScreen(),
        organicCardScreenPath:(context)=>const OrganicCardScreen(),
        dairyCardScreenPath:(context)=>const DairyCardScreen(),
        allCardScreenPath:(context)=>const AllCardScreen(),
       // cropQuestionnaireFormScreenPath:(context)=>const CropRFQScreen(),
        farmerPhoneNumberScreenPath:(context)=>const Phone(),
        farmerPhoneNumberVerificationScreenPath:(context)=>const PhoneVerification(),
        //cropQuestionnaireFormScreenPath:(context)=>const CropQuestionnaireFormScreen(),
       // cropQuestionnaireFormScreenPath:(context)=>const CropQuestionnaireFormScreen(),
        contractPrintScreenPath:(context)=>const ContractPrintScreen(),
        storeScreenPath:(context)=>const StoreScreen(),
        veggiesStoreScreenPath:(context)=>const VeggiesStoreScreen(),
        organicStoreScreenPath:(context)=>const OrganicStoreScreen(),
        fruitStoreScreenPath:(context)=>const FruitStoreScreen(),
        dairyStoreScreenPath:(context)=>const DairyStoreScreen(),


      },
      onGenerateRoute: _getRoute,
    );
  }
}

class InvestorSplashScreenPath {
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }
  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => const LoginScreen(),
    fullscreenDialog: true,
  );
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}