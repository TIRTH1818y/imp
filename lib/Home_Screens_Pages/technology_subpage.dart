import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Home_Screens_Pages/technology.dart';

class techno_subpage extends StatefulWidget {
  final bool colorBW;

  final index;
  final title;

  const techno_subpage(
      {super.key, this.index, this.title, required this.colorBW});

  @override
  State<techno_subpage> createState() => _ListScreenState();
}

class _ListScreenState extends State<techno_subpage> {
  List<List> techs = [
    [
      "Web Development",
      "Mobile App Development",
      "Game Development",
      "Database Management",
      "Cloud Computing",
    ],
    [
      'Network Engineering',
      'Network security',
      'wireless Networking',
    ],
    [
      "Ethical Hacking",
      "Penetration Testing",
      "Incident Response",
      "Digital Forensics",
    ],
    [
      'Data Analysis',
      'Data Mining',
      'Machine Learning',
    ],
    [
      'Application of AI',
      'History of AI',
      'Types of AI',
    ]
  ];

  List<List> techimage = [
    [
      'assets/technology/software.gif',
      'assets/technology/mobileapp.gif',
      'assets/technology/game.gif',
      'assets/technology/database.gif',
      'assets/technology/cloud.gif',
    ],
    [
      'assets/technology/network_eng.gif',
      'assets/technology/network_security.gif',
      'assets/technology/wireless_net.gif',
    ],
    [
      'assets/technology/ethical.gif',
      'assets/technology/penetration_testing.gif',
      'assets/technology/incident_response.gif',
      'assets/technology/digital_forensics.gif',
    ],
    [
      'assets/technology/data_ana.gif',
      'assets/technology/data_mining.gif',
      'assets/technology/machine_learining.gif',
    ],
    [
      'assets/technology/applicaiotn_AI.gif',
      'assets/technology/history_AI.gif',
      'assets/technology/AI_type.gif',
    ]
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorBW ? Colors.white : Colors.black,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 25,
            color: widget.colorBW ? Colors.black : Colors.cyanAccent,
          ),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: widget.colorBW ? Colors.black : Colors.white,
              size: 30,
            )),
      ),
      backgroundColor: widget.colorBW ? Colors.white : Colors.grey[800],
      body: ListView.builder(
        itemCount: techs[widget.index].length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: AnimatedContainer(
              height: 90,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  color: Colors.white60,
                  elevation: 50,
                  borderOnForeground: true,
                  borderRadius: BorderRadius.circular(60),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(techimage[widget.index][index]),
                        radius: 40,
                      ),
                      title: Text(
                        "${techs[widget.index][index]}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (e) => tech_page(
                              techField: widget.title,
                              techSubField: techs[widget.index][index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
