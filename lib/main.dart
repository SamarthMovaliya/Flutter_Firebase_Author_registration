import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_author_regestration/helper/fireStoreHelper.dart';

import 'Globals/Modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> EditKey = GlobalKey<FormState>();
  final GlobalKey<FormState> EditNameKey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController NameEditController =
      TextEditingController(text: Updated['AuthorName']);
  TextEditingController BookController = TextEditingController();
  TextEditingController BookEditController =
      TextEditingController(text: Updated['BookName']);
  String? AuthorName;
  String? BookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text(
          'Author App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: StreamBuilder(
        stream: FireBaseStoreHelper.db.collection("Authors").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata =
                data!.docs;
            return (alldata.isNotEmpty)
                ? Center(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: alldata.length,
                      itemBuilder: (context, i) => Card(
                          child: ListTile(
                        leading: Text(
                          '${i + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        title: Text(
                          '${alldata[i]['AuthorName']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        subtitle: Text(
                          '${alldata[i]['BookName']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Updated = alldata[i].data();
                                    print('--------------------------');
                                    print(Updated);
                                    print('--------------------------');
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          Builder(builder: (context) {
                                        return Builder(builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade50,
                                            title: const Text(
                                              "Author's Details",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: SingleChildScrollView(
                                                child: Form(
                                                  key: EditNameKey,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return 'Please Edit Author Name....';
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (val) {
                                                          setState(() {
                                                            AuthorName = val!;
                                                          });
                                                        },
                                                        controller:
                                                            NameEditController,
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          hintText:
                                                              "Author Name....",
                                                          hintStyle:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                          labelStyle:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                          labelText:
                                                              "Author Name",
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          enabled: true,
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.edit),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return 'Please Edit Book Name....';
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (val) {
                                                          setState(() {
                                                            BookName = val!;
                                                          });
                                                        },
                                                        controller:
                                                            BookEditController,
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          hintText:
                                                              "Book Name....",
                                                          hintStyle:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                          labelStyle:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                          labelText:
                                                              "Book Name",
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          enabled: true,
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.edit),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (EditNameKey.currentState!
                                                      .validate()) {
                                                    EditNameKey.currentState!
                                                        .save();
                                                    Map<String, dynamic>
                                                        tempData = {
                                                      'AuthorName': AuthorName,
                                                      'BookName': BookName,
                                                    };
                                                    print(tempData);
                                                    await FireBaseStoreHelper
                                                        .fireBaseStoreHelper
                                                        .update(data: tempData);
                                                    NameEditController.clear();
                                                    BookEditController.clear();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          2),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    Colors.blue.shade400,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  NameController.clear();
                                                  Navigator.pop(context);
                                                },
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          3),
                                                ),
                                                child: const Text(
                                                  'Cancle',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                      }),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    FireBaseStoreHelper.fireBaseStoreHelper
                                        .Delete(data: alldata[i].data());
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      )),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_book,
                              size: 190,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              '  No Author Found...',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey.shade300,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.blue.shade50,
              title: const Text(
                "Author's Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.5,
                child: SingleChildScrollView(
                  child: Form(
                    key: EditKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please Edit Author Name....';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              AuthorName = val!;
                            });
                          },
                          controller: NameController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Author Name....",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            labelText: "Author Name",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            enabled: true,
                            prefixIcon: const Icon(Icons.edit),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please Edit Book Name....';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              BookName = val!;
                            });
                          },
                          controller: BookController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Book Name....",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            labelText: "Book Name",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            enabled: true,
                            prefixIcon: const Icon(Icons.edit),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (EditKey.currentState!.validate()) {
                      EditKey.currentState!.save();
                      Map<String, dynamic> tempData = {
                        'AuthorName': AuthorName,
                        'BookName': BookName,
                      };
                      print(tempData);
                      await FireBaseStoreHelper.fireBaseStoreHelper
                          .insert(data: tempData);
                      NameController.clear();
                      BookController.clear();
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue.shade400,
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    NameController.clear();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(3),
                  ),
                  child: const Text(
                    'Cancle',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
