import 'dart:convert';
import 'package:fbus_app/main.dart';
import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/environment/environment.dart';
import 'package:fbus_app/src/models/route_model.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String text;

  const CustomDropdown({
    required this.controller,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final String text = widget.controller.text;
      widget.controller.value = widget.controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  void _onItemSelected(RouteModel item) {
    widget.controller.text = item.id;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      // margin: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: ImageHelper.loadFromAsset(
                Helper.getAssetIconName('ico_location.png')),
          ),
          Expanded(
            child: DropdownSearch<RouteModel>(
              asyncItems: (filter) => getData(filter),
              compareFn: (i, s) => i.isEqual(s),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: widget.text,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF323B4B),
                    fontWeight: FontWeight.w400,
                    height: 16 / 14,
                  ).copyWith(
                    fontSize: 16,
                    height: 12 / 10,
                  ),
                  border: InputBorder.none,
                ),
              ),
              onChanged: (RouteModel? selectedValue) {
                setState(() {
                  _onItemSelected(selectedValue!);
                });
              },
              popupProps: PopupPropsMultiSelection.modalBottomSheet(
                // isFilterOnline: true,
                showSelectedItems: true,
                // showSearchBox: true,
                title: Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20),
                  child: Text('List all routes',
                      style: TextStyle(
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),

                itemBuilder: _customPopupItemBuilder,
                // searchFieldProps: TextFieldProps(
                //   controller: widget.controller,
                //   decoration: InputDecoration(
                //     suffixIcon: IconButton(
                //       icon: Icon(Icons.clear),
                //       onPressed: () {
                //         widget.controller.clear();
                //       },
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    RouteModel? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Column(
        children: [
          ListTile(
            selected: isSelected,
            title: Text('Route'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Departure: ${item?.departure ?? ''}'),
                  SizedBox(height: 10),
                  Text('Destination: ${item?.destination ?? ''}'),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Divider(
              thickness: 1,
              color: AppColor.busdetailColor,
            ),
          )
        ],
      ),
    );
  }

  Future<List<RouteModel>> getData(filter) async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/v1/route');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    };

    final http.Response response = await http.get(
      uri,
      headers: headers,
    );
    // Check the response status code
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      // print('DATA $data');
      if (data != null) {
        final routes = List<Map<String, dynamic>>.from(data);
        print(
            'Data: ${routes.map((route) => RouteModel.fromJson(route)).toList()}');
        return routes.map((route) => RouteModel.fromJson(route)).toList();
      }

      return [];
    } else {
      throw Exception(
          'Error fetching routes. Status code: ${response.statusCode}');
    }
  }
}
