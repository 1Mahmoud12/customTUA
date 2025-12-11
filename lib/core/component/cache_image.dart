import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/app_images.dart';

class CacheImage extends StatelessWidget {
  final String? urlImage;
  final bool? profileImage;
  final bool circle;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? errorColor;
  final BoxFit? fit;
  final File? fileImage;
  final Color? svgColor; // إضافة لون للـ SVG

  const CacheImage({
    super.key,
    this.urlImage,
    this.profileImage = false,
    this.width,
    this.height,
    this.borderRadius,
    this.errorColor,
    this.circle = false,
    this.fit,
    this.fileImage,
    this.svgColor, // اللون المطلوب للـ SVG
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipOval(
        clipBehavior: circle ? Clip.hardEdge : Clip.none,
        child:
            fileImage != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  child: Image.file(
                    fileImage!,
                    fit: fit ?? BoxFit.cover,
                    width: width,
                    height: height,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            errorColor != null
                                ? Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                                    color: errorColor,
                                  ),
                                )
                                : profileImage!
                                ? Image.asset(AppImages.defaultProfile)
                                : SvgPicture.asset(AppIcons.logoAppIc, fit: fit ?? BoxFit.cover),
                  ),
                )
                : urlImage != null && !urlImage!.contains('.svg')
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  child: CachedNetworkImage(
                    fit: fit ?? BoxFit.cover,
                    imageUrl: urlImage ?? '',
                    width: width,
                    height: height,
                    placeholder: (context, url) => const LoadingWidget(),
                    errorWidget:
                        (context, url, error) =>
                            errorColor != null
                                ? Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                                    color: errorColor,
                                  ),
                                )
                                : profileImage!
                                ? Image.asset(AppImages.defaultProfile)
                                : IntrinsicWidth(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(color: AppColors.cP50),
                                        alignment: AlignmentDirectional.center,
                                        child: SvgPicture.asset(
                                          AppIcons.logoAppIc,
                                          fit: fit ?? BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [AppColors.black, Colors.transparent],
                                            begin: AlignmentDirectional.centerStart,
                                            end: AlignmentDirectional.centerEnd,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                  ),
                )
                : SvgPictureNetwork(
                  url: urlImage ?? '',
                  color: svgColor,
                  // تمرير اللون للـ SVG
                  width: width,
                  height: height,
                  fit: fit,
                  errorBuilder:
                      (p0) => SizedBox(
                        width: width ?? 30,
                        height: height ?? 30,
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                  placeholderBuilder:
                      (p0) => SizedBox(
                        width: width ?? 30,
                        height: height ?? 30,
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                ),
      ),
    );
  }
}

class SvgPictureNetwork extends StatefulWidget {
  const SvgPictureNetwork({
    super.key,
    required this.url,
    this.placeholderBuilder,
    this.errorBuilder,
    this.color,
    this.width,
    this.height,
    this.fit,
  });

  final String url;
  final Widget Function(BuildContext)? placeholderBuilder;
  final Widget Function(BuildContext)? errorBuilder;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  State<SvgPictureNetwork> createState() => _SvgPictureNetworkState();
}

class _SvgPictureNetworkState extends State<SvgPictureNetwork> {
  Uint8List? _svgFile;
  var _shouldCallErrorBuilder = false;

  @override
  void initState() {
    super.initState();
    _loadSVG();
  }

  Future<void> _loadSVG() async {
    try {
      final svgLoader = SvgNetworkLoader(widget.url);
      final svg = await svgLoader.prepareMessage(context);

      if (!mounted) return;

      setState(() {
        _shouldCallErrorBuilder = svg == null;
        _svgFile = svg;
      });
    } catch (_) {
      setState(() {
        _shouldCallErrorBuilder = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldCallErrorBuilder && widget.errorBuilder != null) {
      return widget.errorBuilder!(context);
    }

    if (_svgFile == null) {
      return widget.placeholderBuilder?.call(context) ?? const SizedBox();
    }

    return SvgPicture.memory(
      _svgFile!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.contain,
      colorFilter: widget.color != null ? ColorFilter.mode(widget.color!, BlendMode.srcIn) : null,
    );
  }
}
