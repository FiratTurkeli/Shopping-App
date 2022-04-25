import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shop_app/providers/like_provider.dart';



class LikeButtonWidget extends StatefulWidget {
  String id;
  LikeButtonWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgerState();
}

class _LikeButtonWidgerState extends State<LikeButtonWidget> {
  bool isLiked = false;
  final key = GlobalKey<LikeButtonState>();
  final animationDuration = const Duration(milliseconds: 300);
  bool hasBackGround = false;
  @override
  Widget build(BuildContext context) {
    final double size = 40;
    return OutlinedButton(
      onPressed: () async {
        setState(() {
          hasBackGround = !isLiked;
        });
        await Future.delayed(const Duration(milliseconds: 250));
        key.currentState!.onTap();
         hasBackGround ? getLikeProvider().like(id: widget.id.toString()) : getLikeProvider().unlike(id: widget.id.toString()) ;
      },
      style:OutlinedButton.styleFrom(
        backgroundColor: isLiked ? Colors.red.shade200 : null,
        fixedSize: const Size.fromWidth(160),
        padding: EdgeInsets.zero,
      ),
      child: IgnorePointer(
        child: LikeButton(
          circleColor: const CircleColor(start: Colors.blue, end: Colors.yellow),
          bubblesColor: const BubblesColor(dotPrimaryColor: Colors.green, dotSecondaryColor: Colors.pink),
          key: key,
          size: size,
          isLiked: isLiked,
            likeCountPadding: const EdgeInsets.only(left: 12) ,
            likeBuilder: (isLiked) {
              final color = isLiked ? Colors.red : Colors.blueGrey;
              return Icon(Icons.favorite, color: color, size: size,);
            },
          animationDuration: animationDuration,
          countBuilder: (count, isLiked, text){
            final color = isLiked ? Colors.red : Colors.blueGrey;

            return Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
            },
          onTap: (isLiked) async {
            this.isLiked = !isLiked;
            Future.delayed(animationDuration).then((value) => setState((){hasBackGround = !isLiked;}));
            return !isLiked;
          },
        ),
      ),
    );
  }
}
