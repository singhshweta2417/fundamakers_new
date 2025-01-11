import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:intl/intl.dart';

class BottomComment extends StatefulWidget {
  const BottomComment({Key? key}) : super(key: key);

  @override
  State<BottomComment> createState() => _BottomCommentState();
}

class _BottomCommentState extends State<BottomComment> {
  List<ListOne> items = [
    ListOne(
        'Shweta Singh',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,'),
    ListOne('Shreya Singh',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500sIt has survived not only five centuries,'),
    ListOne('Anjali',
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500sIt has survived not only five centuries,'),
    ListOne('Navya',
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500sIt has survived not only five centuries,'),
    ListOne('NavyaNanda',
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500sIt has survived not only five centuries,'),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  Widget _buildListItem(BuildContext context, int index) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount:items.length,
        itemBuilder: (context,index){
      return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          leading: const CircleAvatar(
            backgroundImage: AssetImage(Assets.imagesPerson),
            radius: 20,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(items[index].title),
              Text('${DateFormat('HH').format(DateTime.now())} h'),
            ],
          ),
          subtitle: Text(items[index].subTitle),
        ),
      );
    });
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: _textEditingController,
        decoration:  InputDecoration(
          hintText: 'Type something...',
          border: const OutlineInputBorder(),
          suffixIcon:
          InkWell(
            onTap: _sendMessage,
            child: SizedBox(
              height: height*0.028,
              width: width*0.20,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.send, color:AppColors.textButtonColor,size: 18,),
                  Text('Send', style: TextStyle(color:AppColors.textButtonColor,fontSize: 15,fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  void _sendMessage() {
    String message = _textEditingController.text;
    if (message.isNotEmpty) {
      setState(() {
        items.add(ListOne('You', message));
      });
      _textEditingController.clear();
    }
  }


  void _incrementCounter() async {
    await showModalBottomSheet(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: items.length,
                        itemBuilder: _buildListItem,
                      ),
                      _buildTextField(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _incrementCounter,
      child: const Column(
        children: [Icon(Icons.reply), Text('1.5k reply',style: TextStyle(fontSize: 12),)],
      ),
    );
  }
}

class ListOne {
  String title;
  String subTitle;
  ListOne(this.title, this.subTitle);
}
