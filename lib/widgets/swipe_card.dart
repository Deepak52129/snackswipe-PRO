import 'package:flutter/material.dart';
import '../models/restaurant.dart';

enum MoveDirection { none, left, right, up, down }

class SwipeCard extends StatefulWidget {
  final Restaurant restaurant;
  final Function(MoveDirection direction) onSwipeComplete;

  const SwipeCard({
    super.key,
    required this.restaurant,
    required this.onSwipeComplete,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {

  // ----------------------------
  // BADGE VARIABLES
  // ----------------------------
  bool _showBadge = false;
  IconData badgeIcon = Icons.favorite;
  String badgeText = "LIKE";
  Color _badgeColor = Colors.green;

  // ----------------------------
  // MOTION VARIABLES
  // ----------------------------
  Offset _offset = Offset.zero;
  bool _triggerAutoMove = false;
  MoveDirection _moveDirection = MoveDirection.none;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.addListener(() {
      if (_triggerAutoMove) {
        setState(() {
          _offset = Offset(
            _computeXOffset(),
            _computeYOffset(),
          );
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _triggerAutoMove) {
        widget.onSwipeComplete(_moveDirection);

        // Reset card position
        setState(() {
          _offset = Offset.zero;
          _moveDirection = MoveDirection.none;
          _showBadge = false;
          _triggerAutoMove = false;
        });
      }
    });
  }

  // ----------------------------
  // AUTO MOVEMENT OFFSETS
  // ----------------------------
  double _computeXOffset() {
    if (!_triggerAutoMove) return _offset.dx;
    if (_moveDirection == MoveDirection.left) return -500;
    if (_moveDirection == MoveDirection.right) return 500;
    return 0;
  }

  double _computeYOffset() {
    if (!_triggerAutoMove) return _offset.dy;
    if (_moveDirection == MoveDirection.up) return -500;
    if (_moveDirection == MoveDirection.down) return 500;
    return 0;
  }

  // ----------------------------
  // BADGE UPDATE (LIKE / SKIP / WISHLIST)
  // ----------------------------
  void _updateBadge(MoveDirection direction) {
    setState(() {
      _showBadge = true;

      switch (direction) {
        case MoveDirection.right:
          badgeIcon = Icons.favorite;
          badgeText = "LIKE";
          _badgeColor = Colors.red;
          break;

        case MoveDirection.left:
          badgeIcon = Icons.close;
          badgeText = "REJECT";
          _badgeColor = Colors.black;
          break;

        case MoveDirection.up:
          badgeIcon = Icons.bookmark;
          badgeText = "SAVE";
          _badgeColor = Colors.blue;
          break;

        case MoveDirection.down:
          badgeIcon = Icons.arrow_downward;
          badgeText = "SKIP";
          _badgeColor = Colors.grey;
          break;

        case MoveDirection.none:
          _showBadge = false;
          break;
      }
    });
  }

  // ----------------------------
  // DRAG HANDLERS
  // ----------------------------
  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;

      // Detect drag direction
      if (_offset.dx > 40) {
        _moveDirection = MoveDirection.right;
      } else if (_offset.dx < -40) {
        _moveDirection = MoveDirection.left;
      } else if (_offset.dy < -40) {
        _moveDirection = MoveDirection.up;
      } else if (_offset.dy > 40) {
        _moveDirection = MoveDirection.down;
      } else {
        _moveDirection = MoveDirection.none;
      }

      if (_moveDirection != MoveDirection.none) {
        _updateBadge(_moveDirection);
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_moveDirection != MoveDirection.none) {
      // auto animate to end
      _triggerAutoMove = true;
      _controller.forward(from: 0);
    } else {
      // reset back to center
      setState(() {
        _offset = Offset.zero;
        _showBadge = false;
      });
    }
  }

  // ----------------------------
  // UI CARD
  // ----------------------------
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ----------------------------
          // MAIN CARD
          // ----------------------------
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Container(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.restaurant.name,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),

      Text(
        widget.restaurant.cuisine,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),

      const SizedBox(height: 10),
      Text("Tags: ${widget.restaurant.tags.join(', ')}"),

      const SizedBox(height: 10),
      Text("Rating: ${widget.restaurant.rating}/5"),

      const SizedBox(height: 10),
      Text("Price: ₹${widget.restaurant.price}"),

      const SizedBox(height: 10),
      Text("Spice Level: ${widget.restaurant.spiceLevel}"),
    ],
  ),
),

          ),

          // ----------------------------
          // BADGE
          // ----------------------------
          Positioned(
            top: -10,
            left: 100,
            child: AnimatedOpacity(
              opacity: _showBadge ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _badgeColor.withValues(alpha: 0.9),

                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(badgeIcon, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // ----------------------------
          // GESTURE DETECTOR ZONE
          // ----------------------------
          Positioned.fill(
            child: GestureDetector(
              onPanUpdate: _onDragUpdate,
              onPanEnd: _onDragEnd,
            ),
          ),
        ],
      ),
    );
  }
}
