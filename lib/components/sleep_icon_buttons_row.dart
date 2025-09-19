import 'package:flutter/material.dart';
import 'package:meditation_app/providers/audio_filter_provider.dart';
import 'package:provider/provider.dart';

class SleepIconButtonsRow extends StatefulWidget {
  const SleepIconButtonsRow({
    super.key, this.backgroundColor = const Color(0xff586894), this.highlightLabelColor = const Color(0xffffffff)
  });
  final Color backgroundColor;
  final Color highlightLabelColor;

  @override
  State<SleepIconButtonsRow> createState() => _SleepIconButtonsRowState();
}

class _SleepIconButtonsRowState extends State<SleepIconButtonsRow> {
  int selectedIndex = 0;

  _changeBackgroundColorOfButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    FilterType filterType;
    switch (index) {
      case 0:
        filterType = FilterType.all;
        break;
      case 1:
        filterType = FilterType.favorites;
        break;
      case 2:
        filterType = FilterType.anxious;
        break;
      case 3:
        filterType = FilterType.sleep;
        break;
      case 4:
        filterType = FilterType.kids;
        break;
      default:
        filterType = FilterType.all;
    }

    context.read<AudioFilterProvider>().setFilter(filterType);
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 100,
        child: Row(
          spacing: 20,
          children: [
            SizedBox(width: 20,),
            SleepIconButton(backgroundColor: selectedIndex == 0 ? Color(0xff8E97FD) : widget.backgroundColor, text: "All", icon: "assets/images/icons/all_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(0), isSelected: selectedIndex == 0, index: 0, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 1 ? Color(0xff8E97FD) : widget.backgroundColor, text: "My", icon: "assets/images/icons/love_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(1), isSelected: selectedIndex == 1, index: 1, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 2 ? Color.fromARGB(255, 70, 72, 102) : widget.backgroundColor, text: "Anxious", icon: "assets/images/icons/anxious_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(2), isSelected: selectedIndex == 2, index: 2, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 3 ? Color(0xff8E97FD) : widget.backgroundColor, text: "Sleep", icon: "assets/images/icons/moon_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(3), isSelected: selectedIndex == 3, index: 3, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 4 ? Color(0xff8E97FD) : widget.backgroundColor, text: "Kids", icon: "assets/images/icons/kids_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(4), isSelected: selectedIndex == 4, index: 4, highlightLabelColor: widget.highlightLabelColor,),
          ],
        ),
      ),
    );
  }
}

class SleepIconButton extends StatelessWidget {
  const SleepIconButton({
    super.key, required this.backgroundColor, required this.icon, required this.text, required this.onTap, required this.isSelected, required this.index, this.highlightLabelColor = const Color(0xffffffff),
  });
  final Color backgroundColor;
  final String icon;
  final String text;
  final Function(int) onTap;
  final bool isSelected;
  final int index;
  final Color highlightLabelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          AnimatedContainer(
            duration: Duration(microseconds: 200),
            width: 60,
            height: 60,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor
            ),
            child: Image.asset(icon, color: Colors.white, width: 24,),
          ),
          Text(text,
          style: TextStyle(
            color: isSelected ? highlightLabelColor : Colors.grey
          ),
          )
        ],
      ),
    );
  }
}