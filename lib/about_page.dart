import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  BoxDecoration linkBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 2.0,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) // <--- border radius here
      ),
    );
  }

  Widget linkWidget() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: linkBoxDecoration(), // <--- BoxDecoration here
      child: Text(
        //'Beschreibung des Programms: http://fluttercrypto.bplaced.net/flutter-rsa-signature-playground-wc',
        'Program description: http://fluttercrypto.bplaced.net/flutter-rsa-playground',
        style: TextStyle(
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget libraryLinkWidget() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: linkBoxDecoration(), // <--- BoxDecoration here
      child: Text(
        //'Verwendete Kryptographie Bibliothek:'
        'Used crypto library:'
            '\nwebcrypto Version 0.5.2'
            '\nhttps://pub.dev/packages/webcrypto',
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Diese App demonstriert die asymmetrische Signatur auf Basis des RSA Algorithmus.',
                  // 'This app is demonstrating the asymmetric signature on base of RSA algorithm.',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Bitte wählen Sie einen Algorithmus\naus der Liste aus:',
                  // 'Please choose an algorithm:',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () {
                        // own license
                        LicenseRegistry.addLicense(() async* {
                          yield LicenseEntryWithLineBreaks(
                            ['FlutterCrypto RSA Signature Playgound'],
                            'Das Programm unterliegt keiner Lizenz und kann frei verwendet werden (Public Domain).',
                          );
                        });
                        // show license dialog
                        showAboutDialog(
                          context: context,
                          applicationName: widget.title,
                          applicationVersion: '1.0.0',
                          //applicationIcon: MyAppIcon(),
                          applicationIcon: Image.asset('assets/images/flutter_crypto_raw2.png', height: 86, width: 86),
                          applicationLegalese:
                          'Das Programm kann frei verwendet werden (Public Domain)',
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                  'Die App demonstriert die Signatur mit'
                                      ' dem RSA Algorithmus mit den Paddings PKCS 1.5 und PSS.'
                                      '\nDas RSA Schlüsselpaar kann erzeugt und lokal gespeichert werden.'),
                            ),
                          ],
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text('provided by FlutterCrypto')),
                        );
                      },
                      child: Text('über das Programm und Lizenzen'),
                    ),
                  ],
                ),

                // link to fluttercrypto.bplaced.net
                SizedBox(height: 10),
                Link(
                  target: LinkTarget.blank, // new browser, not in app
                  uri: Uri.parse('http://fluttercrypto.bplaced.net/flutter-rsa-signature-playground-wc/'),
                  builder: (context, followLink) => GestureDetector(
                    onTap: followLink,
                    child: linkWidget(),
                  ),
                ),

                // link to pub.dev
                SizedBox(height: 10),
                Link(
                  target: LinkTarget.blank, // new browser, not in app
                  uri: Uri.parse('https://pub.dev/packages/webcrypto'),
                  builder: (context, followLink) => GestureDetector(
                    onTap: followLink,
                    child: libraryLinkWidget(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('back to main app'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
