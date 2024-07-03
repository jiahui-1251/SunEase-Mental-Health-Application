import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationAudioWidget extends StatefulWidget {
  const MeditationAudioWidget({
    super.key,
    required this.audioTitle,
    required this.audioSubtitle,
    required this.backgroundImages,
    required this.videoUrl,
  });

  final String audioTitle;
  final String audioSubtitle;
  final String backgroundImages;
  final String videoUrl;

  @override
  _MeditationAudioWidgetState createState() => _MeditationAudioWidgetState();
}

class _MeditationAudioWidgetState extends State<MeditationAudioWidget> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideThumbnail: true,
        controlsVisibleAtStart: false,
        forceHD: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_controller.value.isReady && !_isPlayerReady) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlayerReady) {
      setState(() {
        if (_isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
        _isPlaying = !_isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: tGreyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(widget.backgroundImages),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Flexible(
            //   flex: 1,
            //   fit: FlexFit.loose,
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: PopupMenuButton(
            //       onSelected: (value) {
            //         // Handle the remove action
            //       },
            //       itemBuilder: (BuildContext context) => [
            //         const PopupMenuItem(
            //           value: 'remove',
            //           child: Text('Remove'),
            //         ),
            //       ],
            //       child: const Icon(
            //         Icons.more_horiz,
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // ),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Container(),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.audioTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          widget.audioSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: _togglePlayPause,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Add a hidden YouTube player for audio playback
            SizedBox(
              height: 0,
              width: 0,
              child: YoutubePlayer(
                controller: _controller,
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
