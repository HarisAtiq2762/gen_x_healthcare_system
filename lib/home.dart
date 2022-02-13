import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gen_x_healthcare_system/details.dart';
import 'package:gen_x_healthcare_system/modals/darkTheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'modals/vitals.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  var  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  var  days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<Vitals>(
        builder: (context,vital,child){
          Provider.of<Vitals>(context,listen: false).getVitals();
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 0.35.sh,
                    width: 1.0.sw,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 90.0, 0.0, 0.0),
                      child: Text('Dashboard',style: GoogleFonts.lato(color: Colors.white,fontSize: 40.sp,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.15.sh, 8.0, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${DateTime.now().day}, ${months[DateTime.now().month]} ${days[DateTime.now().weekday-1]}',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 25.0.sp),),
                            SizedBox(height: 0.02.sh,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[200]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text('${vital.data!=null?vital.data.senorsData.first.heartRate:'...'}',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 20.0.sp)),
                                          Text('Beats Per Minute',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 15.0.sp)),
                                        ],
                                      ),
                                      Container(
                                        height: 0.1.sh,
                                        child: Lottie.asset('assets/annimations/6709-heart-beat.json'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0.02.sh,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text('${vital.data!=null?vital.data.senorsData.first.oxygenSaturation:'...'}',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 20.0.sp)),
                                          Text('Oxygen Saturation',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 15.0.sp)),
                                        ],
                                      ),
                                      Container(
                                        height: 0.1.sh,
                                        child: Lottie.asset('assets/annimations/65851-drop-icon.json'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0.02.sh,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text('${vital.data!=null?vital.data.senorsData.first.bodyTemperature:'...'}',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 20.0.sp)),
                                          Text('Body Temperature',style: GoogleFonts.robotoSlab(color: Colors.black,fontSize: 15.0.sp)),
                                        ],
                                      ),
                                      Container(
                                        height: 0.1.sh,
                                        child: Lottie.asset('assets/annimations/65627-covid-icon-fever.json'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0.0022.sw,-0.00115.sh),
                child: GestureDetector(
                  onTap: (){
                    themeChange.darkTheme = !themeChange.darkTheme;
                  },
                  child: FaIcon(themeChange.darkTheme==true?FontAwesomeIcons.solidSun:FontAwesomeIcons.moon,color: Colors.white,)
                ),
              ),
              Align(
                alignment: Alignment(0,-0.00047.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.2.sw,
                      height: 0.22.sh,
                      decoration: BoxDecoration(
                          color: HexColor('#7250ff'),
                          borderRadius: BorderRadius.circular(35.0)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: HexColor('#583dcb'),
                              child: FaIcon(FontAwesomeIcons.heartbeat,color: Colors.white,),
                            ),
                          ),
                          Text('${vital.data!=null?vital.data.senorsData.first.heartRate:'...'}\nbpm',style: GoogleFonts.lato(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Container(
                      width: 0.2.sw,
                      height: 0.22.sh,
                      decoration: BoxDecoration(
                          color: HexColor('#00d5ff'),
                          borderRadius: BorderRadius.circular(35.0)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: HexColor('#15b1d0'),
                              child: FaIcon(FontAwesomeIcons.water,color: Colors.white,)
                            ),
                          ),
                          Text('${vital.data!=null?vital.data.senorsData.first.oxygenSaturation:'...'}\nSpo2',style: GoogleFonts.lato(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Container(
                      width: 0.2.sw,
                      height: 0.22.sh,
                      decoration: BoxDecoration(
                          color: HexColor('#f7517f'),
                          borderRadius: BorderRadius.circular(35.0)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: HexColor('#cd4269'),
                                child: FaIcon(FontAwesomeIcons.temperatureHigh,color: Colors.white,)
                            ),
                          ),
                          Text('${vital.data!=null?vital.data.senorsData.first.bodyTemperature.substring(0,4):'...'} F\n Temp',style: GoogleFonts.lato(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
          // return Column(
          //   children: [
          //
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: (){
          //           Provider.of<Vitals>(context,listen: false).getVitals();
          //           // Navigator.push(
          //           //   context,
          //           //   MaterialPageRoute(builder: (context) => LineDashed()),
          //           // );
          //         },
          //         child: ListTile(
          //           trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          //           enabled: true,
          //           enableFeedback: true,
          //           tileColor: Theme.of(context).hoverColor,
          //           title: Text('SPO2: ${vital.data!=null?vital.data.senorsData.first.oxygenSaturation:'loading'}',style: TextStyle(color: Colors.white),),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: (){
          //           themeChange.darkTheme = !themeChange.darkTheme;
          //           // Navigator.push(
          //           //   context,
          //           //   MaterialPageRoute(builder: (context) => LineDashed()),
          //           // );
          //         },
          //         child: ListTile(
          //           trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          //           enabled: true,
          //           enableFeedback: true,
          //           tileColor: Colors.blue,
          //           title: Text('Body Temperature: ${vital.data!=null?vital.data.senorsData.first.bodyTemperature:'loading'}',style: TextStyle(color: Colors.white),),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: (){
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => LineDashed()),
          //           );
          //         },
          //         child: ListTile(
          //           trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          //           enabled: true,
          //           enableFeedback: true,
          //           tileColor: Colors.blue,
          //           title: Text('Heart Rate: ${vital.data!=null?vital.data.senorsData.first.heartRate:'loading'}',style: TextStyle(color: Colors.white),),
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}
