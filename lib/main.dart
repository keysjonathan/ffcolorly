import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:colorly_app/login/login_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'new_home_page/new_home_page_widget.dart';
import 'explore/explore_widget.dart';
import 'chat_main/chat_main_widget.dart';
import 'all_users/all_users_widget.dart';
import 'user_profile/user_profile_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<ColorlyAppFirebaseUser> userStream;
  ColorlyAppFirebaseUser initialUser;
  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = colorlyAppFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colorly App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null
          ? Container(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/1_Splash.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : LoginWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'newHomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'newHomePage': NewHomePageWidget(),
      'explore': ExploreWidget(),
      'chatMain': ChatMainWidget(),
      'allUsers': AllUsersWidget(),
      'userProfile': UserProfileWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 28,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.searchLocation,
              size: 20,
            ),
            label: 'Explore',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_rounded,
              size: 22,
            ),
            label: 'Chat',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.users,
              size: 24,
            ),
            label: 'Users',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24,
            ),
            label: 'Profile',
            tooltip: '',
          )
        ],
        backgroundColor: Color(0xFF060606),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Color(0xFFE5831D),
        unselectedItemColor: Color(0xFFA4A4A4),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
