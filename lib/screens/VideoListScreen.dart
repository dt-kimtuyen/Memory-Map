import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPost {
  final String title;
  final String videoId;
  final String uploader;
  final String uploaderAvatar;
  final String timeAgo;
  int likes;
  final int comments;
  final int shares;
  final bool isVerified;
  bool isLiked;

  VideoPost({
    required this.title,
    required this.videoId,
    required this.uploader,
    required this.uploaderAvatar,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isVerified = false,
    this.isLiked = false,
  });
}

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final List<VideoPost> videos = [
    VideoPost(
      title: '🎵 Fresh Music Friday: Top Hits của tuần này! #Music #Trending',
      videoId: 'kJQP7kiw5Fk',
      uploader: 'Music Trends ✓',
      uploaderAvatar: 'https://randomuser.me/api/portraits/men/1.jpg',
      timeAgo: '2 giờ trước',
      likes: 15243,
      comments: 845,
      shares: 324,
      isVerified: true,
    ),
    VideoPost(
      title: '😋 Review món mới tại Sugar Coffee! Matcha Freeze ngon xuất sắc 10 điểm! #Food #Review',
      videoId: 'nPt8bK2gbaU',
      uploader: 'Food Review VN',
      uploaderAvatar: 'https://randomuser.me/api/portraits/women/2.jpg',
      timeAgo: '3 giờ trước',
      likes: 5621,
      comments: 234,
      shares: 89,
      isVerified: true,
    ),
    VideoPost(
      title: '🎮 Hướng dẫn phá đảo game XYZ - Phần 1 #Gaming #Tutorial',
      videoId: 'KNAb2XL7k2g',
      uploader: 'Game Master',
      uploaderAvatar: 'https://randomuser.me/api/portraits/men/3.jpg',
      timeAgo: '5 giờ trước',
      likes: 3452,
      comments: 567,
      shares: 123,
    ),
    VideoPost(
      title: '🐱 Những chú mèo hài hước nhất tuần! Cười không nhặt được mồm 😂 #Pets #Funny',
      videoId: 'dQw4w9WgXcQ',
      uploader: 'Pet Lovers ✓',
      uploaderAvatar: 'https://randomuser.me/api/portraits/women/4.jpg',
      timeAgo: '1 ngày trước',
      likes: 25678,
      comments: 1234,
      shares: 789,
      isVerified: true,
    ),
  ];

  late final List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = videos
        .map(
          (video) => YoutubePlayerController(
        initialVideoId: video.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
          hideThumbnail: false,
        ),
      ),
    )
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleLike(int index) {
    setState(() {
      videos[index].isLiked = !videos[index].isLiked;
      if (videos[index].isLiked) {
        videos[index].likes++;
      } else {
        videos[index].likes--;
      }
    });
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}Tr';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: innerBoxIsScrolled ? 2 : 0,
              floating: true,
              pinned: true,
              title: Row(
                children: [
                  Text(
                    'Watch',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.person, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(video.uploaderAvatar),
                      radius: 24,
                    ),
                    title: Row(
                      children: [
                        Text(
                          video.uploader,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (video.isVerified)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.verified,
                              size: 16,
                              color: Colors.blue[700],
                            ),
                          ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(video.timeAgo),
                        const Text(" • "),
                        Icon(
                          Icons.public,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.more_horiz),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      video.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  YoutubePlayer(
                    controller: _controllers[index],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.redAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatNumber(video.likes),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const Spacer(),
                        Text(
                          '${_formatNumber(video.comments)} bình luận',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const Text(" • "),
                        Text(
                          '${_formatNumber(video.shares)} chia sẻ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInteractionButton(
                          video.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          "Thích",
                          video.isLiked ? Colors.blue[700]! : Colors.black54,
                          onPressed: () => _toggleLike(index),
                        ),
                        _buildInteractionButton(
                          Icons.comment_outlined,
                          "Bình luận",
                          Colors.black54,
                          onPressed: () {},
                        ),
                        _buildInteractionButton(
                          Icons.share_outlined,
                          "Chia sẻ",
                          Colors.black54,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInteractionButton(
      IconData icon,
      String label,
      Color color, {
        VoidCallback? onPressed,
      }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: TextStyle(color: color),
      ),
    );
  }
}