class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage> {
  List dataAll = [
    {
      "id": 1,
      "data": "Pilihan ke - 1",
    },
    {
      "id": 2,
      "data": "Pilihan ke - 2",
    },
    {
      "id": 3,
      "data": "Pilihan ke - 3",
    },
  ];

  late int dataAwal;

  @override
  void initState() {
    super.initState();
    dataAwal = dataAll[0]["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<int>(
            value: dataAwal,
            items: dataAll.map((e) => DropdownMenuItem(
              child: Text("${e['data']}"),
              value: e['id'],
            )).toList(),
            onChanged: (value) {
              setState(() {
                dataAwal = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
