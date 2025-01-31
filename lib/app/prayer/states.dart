// part of 'bloc.dart';
// class PrayerState extends Equatable {
//   final String currentTime;
//   final String currentDate;
//   final String timeLeftForNextPrayer;
//   final List<bool> prayerPassed;
//   final String currentCountry;
//   final String currentState;
//   final String currentCity;

//   const PrayerState({
//     required this.currentTime,
//     required this.currentDate,
//     required this.timeLeftForNextPrayer,
//     required this.prayerPassed,
//     required this.currentCountry,
//     required this.currentState,
//     required this.currentCity,
//   });

//   // Initial State
//   factory PrayerState.initial() {
//     return const PrayerState(
//         currentTime: 'home',
//         currentDate: 'false',
//         timeLeftForNextPrayer: '32',
//         prayerPassed: [],
//         currentCountry: '0',
//         currentState: 'fade',
//         currentCity: 'false');
//   }

//   PrayerState copyWith(
//       {
//        String? currentTime,
//    String? currentDate,
//    String? timeLeftForNextPrayer,
//    List<bool>? prayerPassed,
//    String? currentCountry,
//    String? currentState,
//    String? currentCity,
//       }) {
//     return PrayerState(
//         currentTime: currentTime ?? this.currentTime,
//         currentDate: currentDate ?? this.currentDate,
//         timeLeftForNextPrayer: timeLeftForNextPrayer ?? this.timeLeftForNextPrayer,
//         prayerPassed: prayerPassed ?? this.prayerPassed,
//         currentCountry: currentCountry ?? this.currentCountry,
//         currentState: currentState ?? this.currentState,
//         currentCity: currentCity ?? this.currentCity,
//         );
//   }

//   @override
//   List<Object> get props => [
//           currentTime,
//    currentDate,
//     timeLeftForNextPrayer,
//    prayerPassed,
//     currentCountry,
//     currentState,
//     currentCity,
//       ];
// }
