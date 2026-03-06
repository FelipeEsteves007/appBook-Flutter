import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
class Bookscreen extends StatefulWidget {
  const Bookscreen({super.key});

  @override
  State<Bookscreen> createState() => _BookscreenState();
}

class _BookscreenState extends State<Bookscreen> {
  final TextEditingController  _isbnController = TextEditingController();
  Map<String,dynamic>? bookData;
  bool load = false;
  String? ErrorMessage;

  Future<void> searchBook() async{
    String isbn = _isbnController.text;
    if (isbn.isEmpty) return;

    setState(() {
      load = true;
    });
    
    final url = Uri.parse('https://brasilapi.com.br/api/isbn/v1/$isbn');

    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        setState(() {
          bookData = json.decode(response.body);
          ErrorMessage = null;
        });
      } else {
        setState(() {
          bookData = null;
          ErrorMessage = "Ops! Não encontramos esse livro. \nVerifique o ISBN e tente de novo.";
        });
      }
    } catch (e) {
      print("Erro de conexão: $e");
    } finally {
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF021625);
    const Color gold = Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
            Icons.book_outlined,
          color: gold,
          size: 35,
        ),
        title: const Text(
          'My Books',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Color(0xFF021625),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('ISBN Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
               ),
              ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _isbnController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  cursorColor: gold,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Code',
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,color: gold)
                  ),
                ),
               ),
            ),
              ElevatedButton(
                  onPressed: load ? null : searchBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                ), child: load
                            ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: primary,
                              strokeWidth: 2,
                            ),
                          )
                          :const Text('Search book', style:
                              TextStyle(
                                color: primary
                              ),
                            ),
              ),
              if (ErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 0.5),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(ErrorMessage!, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primary,
                      border: Border.all(color: CupertinoColors.inactiveGray),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Book - Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('isbn: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['isbn'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Title: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['title'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Subtitle: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['subtitle'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Authors: ', style: TextStyle(fontWeight: FontWeight.bold, color: primary)),
                              Expanded(child: Text(bookData?['authors']?.join(', ') ?? '---')),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Publisher: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['publisher'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Synopsis: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['synopsis'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Dimensions: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(
                                child: Text(bookData?['dimensions'] != null
                                    ? "${bookData!['dimensions']['width']} x ${bookData!['dimensions']['height']} ${bookData!['dimensions']['unit']}"
                                    : '---'),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Year: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Text(bookData?['year']?.toString() ?? '---')
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Format: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['format'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Pages: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Text(bookData?['page_count']?.toString() ?? '---')
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Subjects: ', style: TextStyle(fontWeight: FontWeight.bold, color: primary)),
                              Expanded(
                                child: Text(
                                  bookData?['subjects']?.join(', ') ?? '---',
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Location: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['location'] ?? '---'))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Price: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(
                                child: Text(bookData?['retail_price'] != null
                                    ? "${bookData!['retail_price']['currency']} ${bookData!['retail_price']['amount']}"
                                    : '---'),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Url: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(
                                child: bookData?['cover_url'] != null
                                    ? Image.network(bookData!['cover_url'], height: 100)
                                    : const Text('---'),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Provider: ', style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                              Expanded(child: Text(bookData?['provider'] ?? '---'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
