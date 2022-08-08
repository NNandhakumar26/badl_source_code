import 'package:badl_app/style.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Style.nearlyDarkBlue.withOpacity(0.60),
        leadingWidth: 20,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(80),
            //   child: Image(
            //     image: AssetImage('assets/images/jatayu.png'),
            //     height: 40,
            //     width: 40,
            //   ),
            //   // child: CachedNetworkImage(
            //   //   imageUrl: friendImage,
            //   //   placeholder: (conteext, url) => CircularProgressIndicator(),
            //   //   errorWidget: (context, url, error) => Icon(
            //   //     Icons.error,
            //   //   ),
            //   //   height: 40,
            //   // ),
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            Text(
              'Badl Assistance',
              style: Style.headline6.copyWith(
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.w600,
                // fontSize: 20,
                // letterSpacing: .4,
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 2.0,
            //           vertical: 0,
            //         ),
            //         alignment: Alignment.topLeft,
            //         child: Opacity(
            //           opacity: 0.24,
            //           child: Lottie.asset(
            //             'assets/json/leaves.json',
            //             animate: true,
            //             repeat: true,
            //             height: 160,
            //             width: 240,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 2,
            //       child: Center(
            //         // color: Colors.red,
            //         child: Opacity(
            //           opacity: 0.24,
            //           child: RoundedLogoCard(),
            //         ),
            //       ),
            //     ),
            //     Spacer(),
            //     Spacer(),
            //   ],
            // ),

            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SingleMessage(
                          message: 'Something to tell you',
                          isMe: false,
                        ),
                        SingleMessage(
                          message: 'Something to tell you',
                          isMe: true,
                        ),
                        for (var i = 0; i < 15; i++)
                          SingleMessage(
                            message: (i % 2 == 0)
                                ? 'We\'re from Badl team, Thanks for reaching us and we are here glad to help you'
                                : 'I find a suggestion or correction in this page, can you make the appropriate correction and let me know it...',
                            // 'This will be our response over the period of time you use the applictaion and this is what we can do with this',
                            isMe: (i % 2 == 0) ? false : true,
                          )
                      ],
                    ),
                    // child: StreamBuilder(
                    //   stream: FirebaseFirestore.instance
                    //       .collection("users")
                    //       .doc(currentUser.uid)
                    //       .collection('messages')
                    //       .doc(friendId)
                    //       .collection('chats')
                    //       .orderBy("date", descending: true)
                    //       .snapshots(),
                    //   builder: (context, AsyncSnapshot snapshot) {
                    //     if (snapshot.hasData) {
                    //       if (snapshot.data.docs.length < 1) {
                    //         return Center(
                    //           child: Text("Say Hi"),
                    //         );
                    //       }
                    //       return ListView.builder(
                    //         itemCount: snapshot.data.docs.length,
                    //         reverse: true,
                    //         physics: BouncingScrollPhysics(),
                    //         itemBuilder: (context, index) {
                    //           bool isMe = snapshot.data.docs[index]['senderId'] ==
                    //               currentUser.uid;
                    //           return SingleMessage(
                    //               message: snapshot.data.docs[index]['message'],
                    //               isMe: isMe);
                    //         },
                    //       );
                    //     }
                    //     return Center(child: CircularProgressIndicator());
                    //   },
                    // ),
                  ),
                ),
                MessageTextField('12', '12'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  SingleMessage({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: (isMe) ? 16 : 8,
        right: !(isMe) ? 16 : 8,
      ),
      child: Column(
        crossAxisAlignment:
            (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.2),
                decoration: BoxDecoration(
                  color: isMe ? Color(0xff5864e4) : Color(0xffe9e9fb),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        (isMe) ? Radius.circular(12) : Radius.circular(2),
                    bottomRight:
                        !(isMe) ? Radius.circular(12) : Radius.circular(2),
                  ),
                ),
                child: Text(
                  message,
                  style: Style.caption.copyWith(
                    fontSize: 14,
                    color: isMe ? Colors.white : Colors.black.withOpacity(0.72),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Jun 12 | 07:15 A.M',
            style: Style.caption.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.60),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 64,
      padding: EdgeInsets.only(
        right: 12,
        left: 12,
        bottom: 8,
        top: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: Style.bodyText2.copyWith(
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: "Type your Message",
                hintStyle: Style.overline,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Style.nearlyDarkBlue.withOpacity(0.87),
                    width: 1.6,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          BouncingWidget(
            scaleFactor: 1,
            onPressed: () {
              // String message = _controller.text;
              // _controller.clear();
              // await FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(widget.currentId)
              //     .collection('messages')
              //     .doc(widget.friendId)
              //     .collection('chats')
              //     .add({
              //   "senderId": widget.currentId,
              //   "receiverId": widget.friendId,
              //   "message": message,
              //   "type": "text",
              //   "date": DateTime.now(),
              // }).then((value) {
              //   FirebaseFirestore.instance
              //       .collection('users')
              //       .doc(widget.currentId)
              //       .collection('messages')
              //       .doc(widget.friendId)
              //       .set({
              //     'last_msg': message,
              //   });
              // });

              // await FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(widget.friendId)
              //     .collection('messages')
              //     .doc(widget.currentId)
              //     .collection("chats")
              //     .add({
              //   "senderId": widget.currentId,
              //   "receiverId": widget.friendId,
              //   "message": message,
              //   "type": "text",
              //   "date": DateTime.now(),
              // }).then((value) {
              //   FirebaseFirestore.instance
              //       .collection('users')
              //       .doc(widget.friendId)
              //       .collection('messages')
              //       .doc(widget.currentId)
              //       .set({"last_msg": message});
              // });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff313ed1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
