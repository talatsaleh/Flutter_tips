import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  final LayerLink layerLink = LayerLink(); //the link 🔗
  OverlayEntry? overlayEntry; // The overlayEntry
  // function to show the overlay widget
  void showOverlay() {
    overlayEntry = createOverlay();
    Overlay.of(context).insert(overlayEntry!);
  }
  // remove the overlay and set [overlayEntry] to null
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
  // create OverlayEntry 
  OverlayEntry createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox; // gets the RenderBox to get the size or offset of the CustomDropDownWidget
    Size size = renderBox.size; // gets size of CustomDropDownWidget
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: removeOverlay // remove overlay,
        behavior: HitTestBehavior.translucent // Let taps fall through,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower( // the hook 🪝
                link: layerLink // link 🔗,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 10) // if offset is 0,0 then it will appear above it so I want to be under it with padding 10 so I used size.heigt+10 in y axiz,
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('Profile'),
                        onTap: () {
                          //todo: something here done like going to profile.
                          removeOverlay();
                        },
                      ),
                      ListTile(
                        title: Text('Log Out'),
                        onTap: (){
                          //todo: something here done like logout.
                          removeOverlay();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget( // the target 🎯
      link: layerLink,
      child: GestureDetector( 
        onTap: () {
          if (overlayEntry == null) { // if overlayEntry is null then it's closed 
            showOverlay(); // create and show overlay layer
          } else {
            removeOverlay(); // if not so it mean it's opend so we need to remove it 
          }
        },
        child: Row( // here u can remove all thsi and do your custom Ui that will appear 
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            SizedBox(width: 8),
            Text('Hello, Talat'),
          ],
        ),
      ),
    );
  }
}
