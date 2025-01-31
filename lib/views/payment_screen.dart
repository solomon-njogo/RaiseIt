import 'package:flutter/material.dart';
import 'package:raiseit/views/payment_details_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  String selectedCurrency = 'KSH'; // Default currency

  final List<String> currencies = ['KSH', 'USD', 'EUR', 'GBP', 'NGN']; // Add more currencies as needed

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      setState(() {}); // Call setState to rebuild the widget with the new value
    });
  }

  // Function to show currency selection dialog
  void _showCurrencyDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Currency'),
          content: DropdownButton<String>(
            value: selectedCurrency,
            onChanged: (String? newCurrency) {
              setState(() {
                selectedCurrency = newCurrency!;
                Navigator.of(context).pop();  // Close the dialog
              });
            },
            items: currencies.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove app bar shadow
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.currency_exchange),
            onPressed: _showCurrencyDialog, // Show currency selection dialog on button press
          ),
        ],
      ),
      body: SingleChildScrollView(  // Allow scrolling if content exceeds screen size
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input Field with the selected currency as the prefix
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,  // Center the input text
                style: const TextStyle(fontSize: 22), // Adjust font size
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), // Adjust height
                  prefixText: "$selectedCurrency ", // Use selected currency as prefix
                  hintText: "$selectedCurrency ",
                  border: InputBorder.none, // Remove border
                ),
              ),

              const SizedBox(height: 10),

              // Number Pad (Numeric Input Only) - Layout 123, 456, 789, .0<-
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 12, // Number pad 0-9 + .0<- + Clear button
                itemBuilder: (context, index) {
                  String buttonLabel = '';
                  IconData? iconData;

                  // Arrange buttons in the desired order: 123 456 789 .0<-
                  if (index < 9) {
                    buttonLabel = (index + 1).toString();
                  } else if (index == 9) {
                    buttonLabel = '.';
                  } else if (index == 10) {
                    buttonLabel = '0';
                  } else if (index == 11) {
                    buttonLabel = '<-';
                    iconData = Icons.backspace_outlined;
                  }

                  return TextButton(
                    onPressed: () {
                      if (buttonLabel == '<-') {
                        // Remove last character
                        _amountController.text = _amountController.text.isNotEmpty
                            ? _amountController.text.substring(0, _amountController.text.length - 1)
                            : '';
                      } else if (buttonLabel == '.') {
                        // Add dot if it's not already there
                        if (!_amountController.text.contains('.')) {
                          setState(() {
                            _amountController.text += buttonLabel;
                          });
                        }
                      } else {
                        // Append the button value to the current text field (amount)
                        setState(() {
                          _amountController.text += buttonLabel;
                        });
                      }
                    },
                    child: iconData == null
                        ? Text(
                      buttonLabel,
                      style: const TextStyle(fontSize: 24, color: Colors.green), // Green font color
                    )
                        : Icon(iconData, size: 24, color: Colors.green), // Green icon color
                  );
                },
              ),

              const SizedBox(height: 20),

              // Payment Button with dynamic amount
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Here you would handle the payment logic

                    // If payment is successful, show payment details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentDetailsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Adjust padding
                  ),
                  child: Text(
                    'Donate $selectedCurrency ${_amountController.text}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
