import 'package:flutter/material.dart';

class SimpleInterestCal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FillForm();
  }
}

class FillForm extends State<SimpleInterestCal> {
  var _currencies = ['rupees', 'Dollar', 'pounds'];
  String _selectedCurrency = "";

  TextEditingController _tecPrincipal = TextEditingController();
  TextEditingController _tecROI = TextEditingController();
  TextEditingController _tecTerm = TextEditingController();

  final FocusNode _principalFocus = FocusNode();
  final FocusNode _rateOfInterestFocus = FocusNode();
  final FocusNode _termFocus = FocusNode();

  var _displayResult = '';
  var _keyValidationForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text('Interest Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _keyValidationForm,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getImageAsset('images/logo_simple_interest.png'),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: _tecPrincipal,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _principalFocus,
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context)
                              .requestFocus(_rateOfInterestFocus);
                        },
                        decoration: InputDecoration(
                            labelText: 'Principle',
                            labelStyle: textStyleTitle,
                            hintText: 'Enter Principle',
                            hintStyle: textStyleTitle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter principal amount';
                          }
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _tecROI,
                          focusNode: _rateOfInterestFocus,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(_termFocus);
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Rate of Interest',
                            labelStyle: textStyleTitle,
                            hintText: 'In percent',
                            hintStyle: textStyleTitle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter rate of interest';
                            }
                          },
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _tecTerm,
                              focusNode: _termFocus,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Term in years',
                                labelStyle: textStyleTitle,
                                hintStyle: textStyleTitle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter term value';
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                items: _currencies.map((String valueText) {
                                  return DropdownMenuItem<String>(
                                    value: valueText,
                                    child:
                                        Text(valueText, style: textStyleTitle),
                                  );
                                }).toList(),
                                value: _selectedCurrency,
                                onChanged: (String itemSelected) {
                                  //new values
                                  setState(() {
                                    this._selectedCurrency = itemSelected;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                textColor: Theme.of(context).primaryColorDark,
                                child: Text('Calculate', style: textStyleTitle),
                                onPressed: () {
                                  setState(() {
                                    if (_keyValidationForm.currentState
                                        .validate()) {
                                      this._displayResult =
                                          _onPressedButtonCalculate();
                                    }
                                  });
                                }),
                          ),
                          Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).accentColor,
                                child: Text(
                                  'Reset',
                                  style: textStyleTitle,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _onPressedButtonReset();
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(this._displayResult, style: textStyleTitle),
                    )
                  ],
                ),
              )),
        ));
  }

  void _init() {
    this._selectedCurrency = this._currencies[0];
    this._displayResult = 'result will be appear here';
  }

  String _onPressedButtonCalculate() {
    double dAmtPrincipal = double.parse(_tecPrincipal.text);
    double dPerROI = double.parse(_tecROI.text);
    double dYearsTerm = double.parse(_tecTerm.text);
    double totalAmountPayable =
        dAmtPrincipal + (dAmtPrincipal * dPerROI * dYearsTerm) / 100;
    return 'After $dYearsTerm years, your investment will be worth $totalAmountPayable';
  }

  void _onPressedButtonReset() {
    this._tecPrincipal.text = '';
    this._tecROI.text = '';
    this._tecTerm.text = '';
    this._init();
  }

  Widget getImageAsset(String imagePath) {
    AssetImage assetImage = AssetImage(imagePath);
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 200.0,
    );
    return Container(
      child: image,
    );
  }
}
