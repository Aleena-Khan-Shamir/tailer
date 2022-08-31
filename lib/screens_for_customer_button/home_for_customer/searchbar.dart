import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({required this.onChanged, Key? key}) : super(key: key);

  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        controller: _textEditingController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          prefixIconConstraints: BoxConstraints(
            minHeight: 15.h,
            minWidth: 30.w,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: "Locate Us",
          suffixIconConstraints: BoxConstraints(
            minHeight: 15.h,
            minWidth: 30.w,
          ),
          suffixIcon: IconButton(
            constraints: BoxConstraints(
              minHeight: 15.h,
              minWidth: 30.w,
            ),
            splashRadius: 20.r,
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              _textEditingController.clear();
              widget.onChanged(_textEditingController.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}
