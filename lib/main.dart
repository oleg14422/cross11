import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'container_config.dart';  // Ваш файл ContainerConfig

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContainerConfig(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(title)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<ContainerConfig>( // Використовуємо Provider для відстеження змін
          builder: (context, containerConfig, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Виклик секції для слайдерів
                SliderSection(),
                SizedBox(height: 40),
                // Виклик секції для червоного контейнера
                RedContainer(),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Секція для слайдерів
class SliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContainerConfig>(
      builder: (context, containerConfig, child) {
        return Column(
          children: [
            // Слайдер для зміни ширини
            Text('Ширина: ${containerConfig.width.toStringAsFixed(2)}'),
            Slider(
              value: containerConfig.width,
              min: 100.0,
              max: 300.0,
              divisions: 201,
              onChanged: (value) {
                containerConfig.updateWidth(value);
              },
            ),
            SizedBox(height: 20),

            // Слайдер для зміни висоти
            Text('Висота: ${containerConfig.height.toStringAsFixed(2)}'),
            Slider(
              value: containerConfig.height,
              min: 100.0,
              max: 300.0,
              divisions: 201,
              onChanged: (value) {
                containerConfig.updateHeight(value);
              },
            ),
            SizedBox(height: 20),

            // Слайдер для зміни радіусу верхнього правого кута
            Text('Радіус верхнього правого кута: ${containerConfig.borderRadius.toStringAsFixed(2)}'),
            Slider(
              value: containerConfig.borderRadius,
              min: 0.0,
              max: 300,
              divisions: 301,
              onChanged: (value) {
                containerConfig.updateBorderRadius(value);
              },
            ),
          ],
        );
      },
    );
  }
}

// Секція для червоного контейнера
class RedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContainerConfig>(
      builder: (context, containerConfig, child) {
        return Container(
          width: containerConfig.width,
          height: containerConfig.height,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(containerConfig.borderRadius),
            ),
          ),
        );
      },
    );
  }
}
