import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marathon/data/server/api/api_const.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/tools/decoration/res_colors.dart';

class ProjectVideoSection extends StatefulWidget {
  final String email;
  final String project;
  final String tower;
  final String unit;

  const ProjectVideoSection({
    super.key,
    required this.email,
    required this.project,
    required this.tower,
    required this.unit,
  });

  @override
  State<ProjectVideoSection> createState() => _ProjectVideoSectionState();
}

class _ProjectVideoSectionState extends State<ProjectVideoSection> {
  bool showVideo = false;
  bool isVideoLoaded = false;
  bool showVideoButton = false;

  Map<String, dynamic>? videoData;

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _initApi();
  }

  /// ---------------------------
  /// INIT API + HIVE CACHE
  /// ---------------------------
  Future<void> _initApi() async {
    final box = await Hive.openBox('projectVideoBox');

    final key =
        "${widget.project}_${widget.tower}_${widget.unit}";

    /// 1. Check Cache
    if (box.containsKey(key)) {
      videoData = Map<String, dynamic>.from(box.get(key));
      showVideoButton = true;
      setState(() {});
      return;
    }

    /// 2. Call POST API
    final response = await http.post(
      Uri.parse(Api.getDetailForVedioApi),
      body: {
        "project": widget.project,
        "tower": widget.tower,
        "unit": widget.unit,
      },
    );

    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print("--<< Video API called: ${{
        "project": widget.project,
        "tower": widget.tower,
        "unit": widget.unit,
      }}");
      print("--<< Video API Response: $data");
    }

    /// Error Case
    if (data["error"] != null) {
      // print("--<< ${data["error"]}");
      // print("--<< ${{
      //   "project": widget.project,
      //   "tower": widget.tower,
      //   "unit": widget.unit,
      // }}");
      showVideoButton = false;
      setState(() {});
      return;
    }

    /// Save in Hive
    await box.put(key, data);

    videoData = data;
    showVideoButton = true;
    setState(() {});
  }

  /// ---------------------------
  /// BUILD VIDEO URL
  /// ---------------------------
  String _buildVideoUrl() {
    final now = DateTime.now();
    final formattedTimestamp =
        DateFormat('yyyy-MM-dd HH:mm').format(now);

    final uri = Uri(
      scheme: 'https',
      host: 'constra.bandhoo.com',
      path: '/customer-video',
      queryParameters: {
        'email': widget.email,
        'projectId': videoData!['projectId'],
        'towerId': videoData!['towerId'],
        'unitId': videoData!['unitId'],
        'clientId': videoData!['clientId'],
        'signature': videoData!['signature'],
        'timestamp': formattedTimestamp,
      },
    );

    // print("--<< ${uri.toString()}");

    return uri.toString();
  }

  /// ---------------------------
  /// PLAY VIDEO
  /// ---------------------------
  void _playVideo() {
    if (videoData == null) return;
    if(showVideo){
      setState(() {
        showVideo = false;
      });
      return ;
    }
    if(isVideoLoaded){
      setState(() {
        showVideo = true;
      });
      return ;
    }

    final videoUrl = _buildVideoUrl();
    controller.loadRequest(Uri.parse(videoUrl));

    setState(() {
      showVideo = true;
      isVideoLoaded = true;
    });
  }

  @override
  void dispose() {
    controller.runJavaScript('''
      const video = document.querySelector('video');
      if (video) {
        video.pause();
        video.src = '';
      }
    ''');

    super.dispose();
  }

  /// ---------------------------
  /// UI
  /// ---------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Show only if API success
        if (showVideoButton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:TextButton(
            onPressed: _playVideo,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(ColorRes.mainButtonColor.withValues(alpha:0.1)),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Icon(
                  showVideo ? Icons.pause_circle_filled :Icons.play_circle_filled,
                  color: ColorRes.mainButtonColor,
                  size: 30,
                ),
                const SizedBox(width: 4),
                Text(
                  'View Your Apartment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorRes.mainButtonColor,
                  ),
                ),
              ],
            ),
          ),
          ),

        // if (showVideoButton)
        //   Padding(
        //     padding:
        //         const EdgeInsets.symmetric(horizontal: 16),
        //     child: InkWell(
        //       onTap: _playVideo,
        //       child: const Text(
        //         'View Your Apartment',
        //         style: TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w600,
        //           decoration: TextDecoration.underline,
        //           color: Colors.blue,
        //         ),
        //       ),
        //     ),
        //   ),

        if (showVideo)
          const SizedBox(height: 12),

        if (showVideo)
          Container(
            height: 400,
            width: double.maxFinite,
            color: Colors.grey.shade200,
            child: WebViewWidget(controller: controller),
          ),
      ],
    );
  }
}
