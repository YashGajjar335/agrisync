import 'package:agrisync/model/farmer.dart';
import 'package:agrisync/model/specialist.dart';
import 'package:agrisync/model/technology.dart';
import 'package:agrisync/model/thread.dart';
import 'package:agrisync/screens/agriConnect/add_thread.dart';
import 'package:agrisync/screens/agri_tech/add_technology.dart';
import 'package:agrisync/screens/user/edit_profile.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class UserProfileScreen extends StatefulWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Farmer? farmer;
  Specialist? specialist;
  bool isLoad = false;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  loadUser() async {
    AuthServices authServices = AuthServices.instance;
    final user = await authServices.getUserInfo(widget.uid);
    String role = await user["role"];
    print('role : $role');
    setState(() {
      role == "Farmer"
          ? farmer = Farmer.fromMap(user)
          : specialist = Specialist.fromMap(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.profile),
      ),
      body: farmer == null && specialist == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : farmer != null && specialist == null
              ? UserDetail(
                  user: farmer!,
                  isFarmer: true,
                )
              : UserDetail(
                  user: specialist!,
                  isFarmer: false,
                ),
    );
  }
}

class UserDetail extends StatefulWidget {
  final dynamic user;
  final bool isFarmer;
  const UserDetail({super.key, required this.user, required this.isFarmer});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  int userThreads = 0;
  int userTechnology = 0;

  @override
  void initState() {
    countThreadTech();
    super.initState();
  }

  void countThreadTech() async {
    // Count threads for both farmers and specialists
    final threadQuery = FirebaseFirestore.instance
        .collection("Thread")
        .where("uid", isEqualTo: widget.user.uid);

    final threadCount = await threadQuery.count().get();
    setState(() {
      userThreads = threadCount.count!;
    });

    // Count technologies only for specialists
    if (!widget.isFarmer && widget.user.isVerified) {
      final techQuery = FirebaseFirestore.instance
          .collection("Technology")
          .where("uid", isEqualTo: widget.user.uid);

      final techCount = await techQuery.count().get();
      setState(() {
        userTechnology = techCount.count!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(appLocalizations),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextLato(
                text: widget.user.uname,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildActionButtons(appLocalizations),
            if (!widget.isFarmer && widget.user.isVerified)
              LongButton(
                width: width(context) * 0.50,
                buttonText: appLocalizations.add_technology,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTechnology()),
                ),
              ),
            if (!widget.isFarmer && !widget.user.isVerified)
              const Center(
                child: TextLato(
                  text: "Please wait until the admin confirms your request.",
                ),
              ),
            Expanded(
              child: DefaultTabController(
                length: widget.isFarmer
                    ? 1
                    : widget.user.isVerified
                        ? 2
                        : 1,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: TabBar(
                      tabs: [
                        TextLato(
                          text: appLocalizations.your_thread,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        if (!widget.isFarmer && widget.user.isVerified)
                          TextLato(
                            text: appLocalizations.your_technologies,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      _buildThreadList(appLocalizations),
                      if (!widget.isFarmer && widget.user.isVerified)
                        _buildTechnologyList(appLocalizations),
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

  Widget _buildProfileHeader(AppLocalizations appLocalizations) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                widget.user.profilePic.isEmpty
                    ? const CircleAvatar(
                        backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                        radius: 30,
                      )
                    : StringImageInCircleAvatar(
                        base64ImageString: widget.user.profilePic,
                        radius: 30,
                      ),
                if (!widget.isFarmer && widget.user.isVerified)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12,
                      child: TextLato(
                        text: "S",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            NumberAndText(
              number: userThreads,
              lable: appLocalizations.thread,
            ),
            if (!widget.isFarmer && widget.user.isVerified)
              NumberAndText(
                number: userTechnology,
                lable: appLocalizations.technology,
              ),
            NumberAndText(
              number: widget.user.following.length,
              lable: appLocalizations.following,
            ),
            NumberAndText(
              number: widget.user.followers.length,
              lable: appLocalizations.followers,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(AppLocalizations appLocalizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LongButton(
          width: width(context) * 0.4,
          buttonText: appLocalizations.edit_profile,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditProfile()),
          ),
        ),
        LongButton(
          width: width(context) * 0.4,
          buttonText: appLocalizations.add_thread,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddThread()),
          ),
        ),
      ],
    );
  }

  Widget _buildThreadList(AppLocalizations appLocalizations) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Thread")
          .where('uid', isEqualTo: widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final int threadCount = snapshot.data!.size;
            return threadCount == 0
                ? Center(
                    child: TextLato(
                      text: appLocalizations.no_thread_available,
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 1,
                      mainAxisExtent: 100,
                    ),
                    itemCount: threadCount,
                    itemBuilder: (context, index) {
                      Thread thread =
                          Thread.fromSnap(snapshot.data!.docs[index]);
                      return InkWell(
                        onTap: () {
                          showImage(context, thread.photoUrl);
                        },
                        child: Card(
                          child: StringImage(
                            base64ImageString: thread.photoUrl,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildTechnologyList(AppLocalizations appLocalizations) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Technology")
          .where('uid', isEqualTo: widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final int technologyCount = snapshot.data!.size;
            return technologyCount == 0
                ? Center(
                    child: TextLato(
                      text: appLocalizations.no_technology_available,
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 1,
                      mainAxisExtent: 100,
                    ),
                    itemCount: technologyCount,
                    itemBuilder: (context, index) {
                      Technology technology =
                          Technology.fromSnap(snapshot.data!.docs[index]);
                      return InkWell(
                        onTap: () {
                          showImage(context, technology.photoUrl);
                        },
                        child: Card(
                          child: StringImage(
                            base64ImageString: technology.photoUrl,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingScreen();
        }
        return const WaitingScreenWithWarnning();
      },
    );
  }
}

class NumberAndText extends StatelessWidget {
  final int number;
  final String lable;
  const NumberAndText({super.key, required this.number, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextLato(
            text: number.toString(),
            fontSize: 25,
          ),
          TextLato(
            text: lable,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
