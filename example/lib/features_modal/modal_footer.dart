import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesModalFooter extends StatefulWidget {
  @override
  _FeaturesModalFooterState createState() => _FeaturesModalFooterState();
}

class _FeaturesModalFooterState extends State<FeaturesModalFooter> {

  int _question1;
  List<int> _question2;

  List<String> _options1 = [
    'Very Satisfied',
    'Somewhat Satisfied',
    'Neither Satisfied or Dissatisfied',
    'Somewhat Dissatisfied',
    'Very Dissatisfied',
  ];
  List<String> _options2 = [
    'Reliable',
    'High Quality',
    'Usefull',
    'Unique',
    'Impractical',
    'Ineffective',
    'Poor Quality',
    'Unreliable',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<int>.single(
          title: 'Overall, how satisfied are you with smart_select package?',
          value: _question1,
          options: S2Option.listFrom<int, String>(
            source: _options1,
            value: (i, v) => i,
            title: (i, v) => v
          ),
          modalConfig: S2ModalConfig(
            type: S2ModalType.popupDialog,
            style: S2ModalStyle(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
            ),
          ),
          choiceType: S2ChoiceType.radios,
          onChange: (state) => setState(() => _question1 = state.value),
          tileBuilder: (context, state) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 15,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: S2Tile.fromState(
                  state,
                  hideValue: true,
                  leading: CircleAvatar(
                    backgroundColor: _question1 == null ? Colors.grey : Colors.blue,
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              ),
            );
          },
          modalHeaderBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: state.modalTitle,
            );
          },
        ),
        SmartSelect<int>.multiple(
          title: 'Which of following words would you use to describe smart_select?',
          value: _question2,
          options: S2Option.listFrom<int, String>(
            source: _options2,
            value: (i, v) => i,
            title: (i, v) => v
          ),
          onChange: (state) => setState(() => _question2 = state.value),
          choiceConfig: S2ChoiceConfig(
            type: S2ChoiceType.checkboxes,
            layout: S2ChoiceLayout.grid,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              crossAxisCount: 2
            ),
            style: S2ChoiceStyle(
              control: S2ChoiceControl.leading,
              wrapperPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
          ),
          modalConfirmation: true,
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 15,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: S2ChipsTile<int>(
                  state: state,
                  title: Text(state.title),
                  // subtitle: Text('lorem impsum'),
                  leading: CircleAvatar(
                    backgroundColor: _question2 == null ? Colors.grey : Colors.blue,
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white)
                    ),
                  ),
                  // trailing: Icon(Icons.add_circle_outline),
                  // scrollable: true,
                  // divider: Divider(height: 1),
                  hidePlaceholder: true,
                  chipColor: Colors.blue,
                  chipBrightness: Brightness.dark,
                ),
              ),
            );
          },
          modalHeaderBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: state.modalTitle,
            );
          },
          modalFooterBuilder: (context, state) {
            final int count = state.cache.length;
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: FlatButton(
                  child: Text('Submit ($count)'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: count > 0 ? () => state.closeModal(confirmed: true) : null,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}