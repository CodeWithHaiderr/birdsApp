import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BirdsInfoHome extends StatefulWidget {
  final String? title;
  final dynamic data;
  const BirdsInfoHome({super.key,required this.title, required this.data});

  @override
  State<BirdsInfoHome> createState() => _BirdsInfoHomeState();
}

class _BirdsInfoHomeState extends State<BirdsInfoHome> {
//  final videoUrl = "https://www.youtube.com/watch?v=r-jLzGLWXi8";

  late YoutubePlayerController _controller;
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.data['Youtube']);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
     );

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    // final listDetail = ModalRoute.of(context)!.settings.arguments as BirdsInfoModel;
    // var jsonData = json.decode(listDetail.bName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        title: Text('${widget.title}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxSwiper.builder(
                              itemCount: widget.data['BImg'].length,
                              // autoPlay: true,
                              height:200,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.9,
                              itemBuilder: (context,index) {
                                return Image.network(
                                  widget.data["BImg"],
                                  width: double.infinity,
                                  fit: BoxFit.fitHeight,
                                );
                              }),

                          const SizedBox(height: 20,),
                          Text(widget.title!,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23),),
                          const SizedBox(height: 10,),
                          Text("${widget.data['BDesc']}"),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Text("Breeding Age:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Expanded(child: Text("${widget.data['BreedingAge']}")),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              const Text("Breeding Temperature:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("${widget.data['BreedingTemp']}"),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              const Text("Eggs per clutch:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("${widget.data['BEggs']}"),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              onReady: () => debugPrint('ready'),
                              bottomActions: [
                                CurrentPosition(),
                                ProgressBar(
                                  isExpanded: true,
                                  colors: const ProgressBarColors(
                                    playedColor: Colors.grey,
                                    handleColor: Colors.amberAccent,
                                  ),
                                ),
                                const PlaybackSpeedButton(),
                              ],
                            ),
                          ),
                          const Text("Diet:  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(height: 3,),
                          Text("${widget.data['Diet']}"),
                          const SizedBox(height: 10,),
                          const Text("Ideal Cage Size:  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(height: 3,),
                          Text("${widget.data['CageSize']}"),




                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),

    );
  }
}

