import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Home_Screens_Pages/technology_subpage.dart';

class techno_page extends StatefulWidget {
  final bool colorBW;

  const techno_page({super.key, required this.colorBW});

  @override
  State<techno_page> createState() => _ListScreenState();
}

class _ListScreenState extends State<techno_page> {
  List<String> Fields = [
    "Software Development",
    "Networking",
    "CyberSecurity",
    "Data Science",
    "Artificial intelligence",
  ];

  List<String> subtitle = [
    'Web Development,Mobile App Development......',
    'Network Engineering,2.	Network security.....',
    'Ethical Hacking,Penetration Testing...',
    'Data Analysis,Data mining...',
    'Application of AI,History of AI....',
  ];

  List<String> image = [
    'assets/technology/web.gif',
    'assets/technology/net.gif',
    'assets/technology/cyber.gif',
    'assets/technology/data.gif',
    'assets/technology/ai.gif',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Fields.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: AnimatedContainer(
            height: 90,
            duration: const Duration(milliseconds: 300),
            child: Material(
              color: Colors.white54,
              elevation: 50,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(60),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(image[index]),
                    radius: 40,
                  ),
                  title: Text(
                    Fields[index],
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    subtitle[index],
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (e) => techno_subpage(
                          colorBW: widget.colorBW,
                          title: Fields[index],
                          index: Fields.indexOf(Fields[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
