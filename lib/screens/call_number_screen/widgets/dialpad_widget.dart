import 'package:asmart_linphone/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class DialPadWidget extends StatefulWidget {
  final void Function(String number)? onCall;

  const DialPadWidget({super.key, this.onCall});

  @override
  State<DialPadWidget> createState() => _DialPadWidgetState();
}

class _DialPadWidgetState extends State<DialPadWidget> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '*',
    '0',
    '#',
  ];

  void _onKeyTap(String value) {
    _controller.text += value;
  }

  void _onBackspace() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      _controller.text = text.substring(0, text.length - 1);
    }
  }

  void _onCall() {
    if (_controller.text.isNotEmpty) {
      widget.onCall?.call(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.black, fontSize: 36),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Нажмите чтобы ввести логин',
                        hintStyle: TextStyle(
                          color: Colors.black12,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _onBackspace,
                    icon: const Icon(Icons.backspace),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  itemCount: _buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final label = _buttons[index];
                    return ElevatedButton(
                      onPressed: () => _onKeyTap(label),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: ElevatedButton(
                  onPressed: _onCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightTheme.primaryColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.call, size: 32, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
