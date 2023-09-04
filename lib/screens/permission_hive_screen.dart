import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final _hiveBox = Hive.box("login-info");
  int _currentItem = 1;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    _initializeBox();
    super.initState();
  }

  void _initializeBox() {
    print('entering initialize method');
    print(_hiveBox.keys.length);
    final list = _hiveBox.keys.map((key) {
      final data = _hiveBox.get(key);
      return {
        'key': key,
        'name': data['name'],
        'age': data['age'],
        'isActive': data['isActive']
      };
    }).toList();
    _items = list.reversed.toList();
    print("item Length: ${_items.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _onSubmit,
            style: getBtnStyle(context),
            child: const Text("check Permission"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _viewData,
            style: getBtnStyle(context),
            child: const Text("View database"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _deleteDatabase,
            style: getBtnStyle(context),
            child: const Text("Delete Database"),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.redAccent,
            height: 300,
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(_items[i]['name'].toString()),
                  subtitle: Text(_items[i]['isActive'].toString()),
                  leading: Text(_items[i]['age'].toString()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToDatabase(
              {'name': 'Jb_Jason$_currentItem', 'age': 20, 'isActive': true});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addToDatabase(Map<String, dynamic> newData) async {
    await _hiveBox.add(newData);
    _currentItem++;
    print('item added');
    _initializeBox();
  }

  void _deleteDatabase() async {
    print('delete comint ');
    // _hiveBox.delete(1);
    // _hiveBox.delete(2);
    // _hiveBox.delete(3);
    await _hiveBox.clear();
    print(_hiveBox.keys.length);
    setState(() {});
  }

  void _viewData() {
    print(_hiveBox.keys.length);
    for (int i = 0; i < _hiveBox.keys.length; i++) {
      print(_hiveBox.get(i));
    }
  }

  void _onSubmit() async {
    try {
      final status = await Permission.photos.request();
      print("status: $status");
      if (status == PermissionStatus.denied) {
        _showAlertDialog();
        // openAppSettings()
      } else {
        print('Permission granted Occured');
      }
    } catch (e) {
      print('Exception Occured');
    }
  }

  _showAlertDialog() async {
    if (Platform.isAndroid) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Permission Denied!"),
            content: const Text("Allow access to gallery and photos"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => openAppSettings(),
                child: const Text('Settings'),
              ),
            ],
          );
        },
      );
    } else {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );
    }
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.teal,
      fixedSize: Size(MediaQuery.of(context).size.width - 40, 47),
      textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20));
}

class Testing2 extends StatefulWidget {
  const Testing2({super.key});
  @override
  State<Testing2> createState() => _Testing2State();
}

class _Testing2State extends State<Testing2> {
  final _shoppingBox = Hive.box("login-info");
  final int _currentItem = 1;
  Map<String, dynamic> _item = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _addItem({
              'id': 1,
              'name': 'Jb_Jason$_currentItem',
              'age': 20,
              'isActive': true
            }),
            style: getBtnStyle(context),
            child: const Text("Add to Database"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _viewItem,
            style: getBtnStyle(context),
            child: const Text("View database"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _deleteItem,
            style: getBtnStyle(context),
            child: const Text("Delete Database"),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.redAccent,
            height: 300,
            child: _item.isEmpty
                ? const Center(
                    child: Text(
                      'No Item!',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  )
                : ListTile(
                    leading: Text(_item['id'].toString()),
                    title: Text("${_item['name']} age: ${_item['age']}"),
                    subtitle: Text(_item['isActive'].toString()),
                  ),
          ),
        ],
      ),
    );
  }

  void _addItem(Map<String, dynamic> newItem) async {
    try {
      await _shoppingBox.put(1, newItem);
      print('item added Successfully');
      _item = newItem;
      setState(() {});
    } catch (e) {
      print('Error Occured $e');
    }
  }

  void _viewItem() {
    print(_shoppingBox.get(1));
  }

  void _deleteItem() async {
    try {
      await _shoppingBox.delete(1);
      print('item Deleted ${_shoppingBox.get(1)}');
      _item = {};
      setState(() {});
    } catch (e) {
      print('Error Occured $e');
    }
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.teal,
      fixedSize: Size(MediaQuery.of(context).size.width - 40, 47),
      textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20));
}
