import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('So sánh Expanded vs Không Expanded'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '❌ Bị Overflow'),
                Tab(text: '✅ Không Overflow'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // TAB 1: BỊ OVERFLOW
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.yellow[100],
                    child: const Column(
                      children: [
                        Text(
                          'LỖI: BỊ OVERFLOW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('4 Container × 200px = 800px'),
                        Text('Màn hình chỉ có ~600px'),
                        Text('→ Tràn ra ngoài (overflow)'),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    color: Colors.red,
                    child: const Center(child: Text('Container 1 (200px)')),
                  ),
                  Container(
                    height: 200,
                    color: Colors.orange,
                    child: const Center(child: Text('Container 2 (200px)')),
                  ),
                  Container(
                    height: 200,
                    color: Colors.green,
                    child: const Center(child: Text('Container 3 (200px)')),
                  ),
                  Container(
                    height: 200,
                    color: Colors.blue,
                    child: const Center(child: Text('Container 4 (200px)')),
                  ),
                ],
              ),
              
              // TAB 2: KHÔNG OVERFLOW (DÙNG EXPANDED)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[100],
                    child: const Column(
                      children: [
                        Text(
                          'ĐÚNG: KHÔNG OVERFLOW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('4 Expanded chia đều không gian'),
                        Text('Mỗi cái chiếm 25% chiều cao'),
                        Text('→ Tự động co dãn vừa đủ'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: const Center(child: Text('Expanded 1 (25%)')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.orange,
                      child: const Center(child: Text('Expanded 2 (25%)')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      child: const Center(child: Text('Expanded 3 (25%)')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: const Center(child: Text('Expanded 4 (25%)')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}