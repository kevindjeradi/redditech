import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/themes/customcolors.dart';
import 'loading_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  List<String> description = [
    "Cacher son profil des bots",
    "Afficher les feeds privés",
    "Cacher les publicités",
    "Afficher les posts +18",
    "Cacher les posts profanes",
    "Auto-renouveler les crédits Reddit",
    "label nsfw",
    "third_party_data_personalized_ads"
  ];

  Map<String, bool> reglagesApi = {
    'hide_from_robots': false,
    'private_feeds': false,
    'hide_ads': false,
    'over_18': false,
    'no_profanity': false,
    'creddit_autorenew': false,
    'label_nsfw': false,
    'third_party_data_personalized_ads': false,
  };

  List<String> reglages = [
    "hide_from_robots",
    "label_nsfw",
    "over_18",
    "no_profanity",
    "private_feeds",
    "hide_ads",
    "creddit_autorenew",
    "third_party_data_personalized_ads"
  ];

  Map<String, dynamic> mapReglages = {};

  @override
  void initState() {
    super.initState();
  }

  getReglages() async {
    mapReglages = await Api.getPrefs();
    reglagesApi['hide_from_robots'] = mapReglages['hide_from_robots'];
    reglagesApi['no_profanity'] = mapReglages['no_profanity'];
    reglagesApi['label_nsfw'] = mapReglages['label_nsfw'];
    reglagesApi['private_feeds'] = mapReglages['private_feeds'];
    reglagesApi['hide_ads'] = mapReglages['hide_ads'];
    reglagesApi['over_18'] = mapReglages['over_18'];
    reglagesApi['creddit_autorenew'] = mapReglages['creddit_autorenew'];
    reglagesApi['third_party_data_personalized_ads'] =
        mapReglages['third_party_data_personalized_ads'];
    return (reglagesApi);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getReglages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              color: CustomColors.greyDarken3,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                          itemCount: reglagesApi.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  textColor: Colors.white,
                                  title: Text(reglages[index]),
                                  subtitle: Text(description[index]),
                                  trailing: BouttonReglage(
                                      wholeSettings: mapReglages,
                                      settings: reglagesApi,
                                      index: reglages[index]),
                                ));
                          }))
                ],
              ),
            );
          }
          return const LoadingScreen();
        });
  }
}

class BouttonReglage extends StatefulWidget {
  final Map<String, dynamic> wholeSettings;
  final Map<String, bool> settings;
  final String index;

  const BouttonReglage(
      {Key? key,
      required this.settings,
      required this.index,
      required this.wholeSettings})
      : super(key: key);

  @override
  _BouttonReglage createState() => _BouttonReglage();
}

class _BouttonReglage extends State<BouttonReglage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (value) {
        setState(() {
          widget.settings[widget.index] = value;
          widget.wholeSettings[widget.index] = value;
          Api.savePrefs(widget.wholeSettings);
        });
      },
      activeTrackColor: CustomColors.attentionMessage,
      activeColor: CustomColors.white,
      value: widget.settings[widget.index]!,
    );
  }
}
