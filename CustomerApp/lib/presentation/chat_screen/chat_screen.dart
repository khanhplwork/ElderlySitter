import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/process/bloc/chat_bloc.dart';
import 'package:elscus/process/event/chat_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkjs_flutter/talkjs_flutter.dart';
import '../../core/constants/color_constant.dart';
import '../../core/utils/globals.dart' as globals;

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required this.otherID,
      required this.otherName,
      required this.otherEmail,
      required this.otherAvaUrl})
      : super(key: key);
  String otherID;
  String otherName;
  String otherEmail;
  String otherAvaUrl;

  @override
  // ignore: no_logic_in_create_state
  State<ChatScreen> createState() => _ChatScreenState(
      otherID: otherID,
      otherName: otherName,
      otherEmail: otherEmail,
      otherAvaUrl: otherAvaUrl);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState(
      {required this.otherID,
      required this.otherName,
      required this.otherEmail,
      required this.otherAvaUrl});

  String otherID;
  String otherName;
  String otherEmail;
  String otherAvaUrl;
  final chatBloc = ChatBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final session = Session(appId: 'tYnvNipa');

    final me = session.getUser(
      id: globals.cusDetailModel!.id,
      name: globals.cusDetailModel!.fullName,
      email: [globals.cusDetailModel!.email],
      photoUrl: (globals.cusDetailModel!.avatarImgUrl.isEmpty) ? ImageConstant.defaultAva : globals.cusDetailModel!.avatarImgUrl,
      // welcomeMessage: '',
      role: 'default',
    );
    session.me = me;
    final other = session.getUser(
      id: otherID,
      name: otherName,
      email: [otherEmail],
      photoUrl: otherAvaUrl,
      // welcomeMessage: 'Hey there! How are you? :-)',
      role: 'default',
    );

    final conversation = session.getConversation(
      id: Talk.oneOnOneId(me.id, other.id),
      participants: {Participant(me), Participant(other)},
    );
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
      stream: chatBloc.stateController.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Els Chat Demo',
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.primaryColor,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: size.height * 0.03,
                ),
              ),
              title: Text(
                'Cuộc Trò Chuyện',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: size.height * 0.026,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Stack(
              children: [
                ChatBox(
                  session: session,
                  conversation: conversation,
                  onSendMessage: (event) {
                    chatBloc.eventController.sink.add(SendMsgChatEvent(otherID: otherID));
                  },
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.14,
                  color: Colors.white,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.14,
                    margin: EdgeInsets.all(size.height * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.015),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.height * 0.1,
                          height: size.height * 0.1,
                          margin: EdgeInsets.all(size.height * 0.01),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(otherAvaUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          otherName,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w400,
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
        );
      }
    );
  }
}
