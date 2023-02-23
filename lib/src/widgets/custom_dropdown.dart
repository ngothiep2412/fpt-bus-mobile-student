import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/models/user_model.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';

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

  void _onItemSelected(UserModel item) {
    widget.controller.text = item.name;
  }

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

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
            child: DropdownSearch<UserModel>(
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
              onChanged: (UserModel? selectedValue) {
                setState(() {
                  _onItemSelected(selectedValue!);
                });
              },
              popupProps: PopupPropsMultiSelection.modalBottomSheet(
                isFilterOnline: true,
                showSelectedItems: true,
                showSearchBox: true,
                itemBuilder: _customPopupItemBuilder,
                searchFieldProps: TextFieldProps(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        widget.controller.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    UserModel? item,
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
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.createdAt?.toString() ?? ''),
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}
