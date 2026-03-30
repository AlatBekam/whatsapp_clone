import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/theme/theme.dart';

class KolomChat extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() Sending;
  final bool Loading;

  const KolomChat({
    required this.controller,
    required this.Sending,
    required this.Loading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          prefixIcon: const Icon(Icons.emoji_emotions),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (_) => () async {Sending();},
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: warna.Hijau(),
                        shape: BoxShape.circle,
                      ),
                      child: 
                          Loading
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () async {await Sending();},
                                icon: Icon(Icons.send),
                                color: Colors.white,
                              ),
                    ),
                  ],
                );
    
  }
}