import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Stateful App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ApiProvider(api: Api(), child: const HomePage()),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiProvider.of(context).api.dateAndTime ?? ''),
      ),
      body: GestureDetector(
        onTap: () async {
          final api = ApiProvider.of(context).api;
          final dateAndTime = await api.getDateAndTime();
          setState(() {
            //it cannot be null
            //title = DateTime.now().toIso8601String();
            _textKey = ValueKey(dateAndTime);
          });
        },
        child: SizedBox.expand(
          child: Container(
            color: Colors.white,
            child: DateTimeWidget(key: _textKey),
            )),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(
      api.dateAndTime ?? 'Tap on screen to fetch date and time',
    );
  }
}

//We will display the current time in our Scaffold app bar and in a text widget independently

//API provider can wrap our homepage so that it is available for all its descendants


 class Api{
  //provider class that inherits from InheritedWidget
  //a way to check whether the inherited class is completely been replaced  - uuid

  String? dateAndTime;
  getDateAndTime() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => DateTime.now().toIso8601String(),
    ).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}
class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;

  ApiProvider({Key? key, required this.api, required Widget child})
      : uuid = const Uuid().v4(),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
  
 }
