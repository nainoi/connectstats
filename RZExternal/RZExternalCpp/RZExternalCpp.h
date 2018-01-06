//
//  RZExternalCpp.h
//  RZExternalCpp
//
//  Created by Brice Rosenzweig on 06/01/2018.
//  Copyright © 2018 Brice Rosenzweig. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

//! Project version number for RZExternalCpp.
FOUNDATION_EXPORT double RZExternalCppVersionNumber;

//! Project version string for RZExternalCpp.
FOUNDATION_EXPORT const unsigned char RZExternalCppVersionString[];
#endif

// In this header, you should import all the public headers of your framework using statements like #import <RZExternalCpp/PublicHeader.h>


#import "fit_mesg.hpp"
#import "fit_mesg_broadcast_plugin.hpp"
#import "fit_mesg_broadcaster.hpp"
#import "fit_mesg_capabilities_mesg.hpp"
#import "fit_mesg_capabilities_mesg_listener.hpp"
#import "fit_mesg_definition.hpp"
#import "fit_mesg_definition_listener.hpp"
#import "fit_mesg_listener.hpp"
#import "fit_mesg_with_event.hpp"
#import "fit_mesg_with_event_broadcaster.hpp"
#import "fit_mesg_with_event_listener.hpp"
#import "fit_met_zone_mesg.hpp"
#import "fit_met_zone_mesg_listener.hpp"
#import "fit_monitoring_info_mesg.hpp"
#import "fit_monitoring_info_mesg_listener.hpp"
#import "fit_monitoring_mesg.hpp"
#import "fit_monitoring_mesg_listener.hpp"
#import "fit_nmea_sentence_mesg.hpp"
#import "fit_nmea_sentence_mesg_listener.hpp"
#import "fit_obdii_data_mesg.hpp"
#import "fit_obdii_data_mesg_listener.hpp"
#import "fit_ohr_settings_mesg.hpp"
#import "fit_ohr_settings_mesg_listener.hpp"
#import "fit_pad_mesg.hpp"
#import "fit_pad_mesg_listener.hpp"
#import "fit_power_zone_mesg.hpp"
#import "fit_power_zone_mesg_listener.hpp"
#import "fit_profile.hpp"
#import "fit_protocol_validator.hpp"
#import "fit_record_mesg.hpp"
#import "fit_record_mesg_listener.hpp"
#import "fit_runtime_exception.hpp"
#import "fit_schedule_mesg.hpp"
#import "fit_schedule_mesg_listener.hpp"
#import "fit_sdm_profile_mesg.hpp"
#import "fit_sdm_profile_mesg_listener.hpp"
#import "fit_segment_file_mesg.hpp"
#import "fit_segment_file_mesg_listener.hpp"
#import "fit_segment_id_mesg.hpp"
#import "fit_segment_id_mesg_listener.hpp"
#import "fit_segment_lap_mesg.hpp"
#import "fit_segment_lap_mesg_listener.hpp"
#import "fit_segment_leaderboard_entry_mesg.hpp"
#import "fit_segment_leaderboard_entry_mesg_listener.hpp"
#import "fit_segment_point_mesg.hpp"
#import "fit_segment_point_mesg_listener.hpp"
#import "fit_session_mesg.hpp"
#import "fit_session_mesg_listener.hpp"
#import "fit_slave_device_mesg.hpp"
#import "fit_slave_device_mesg_listener.hpp"
#import "fit_software_mesg.hpp"
#import "fit_software_mesg_listener.hpp"
#import "fit_speed_zone_mesg.hpp"
#import "fit_speed_zone_mesg_listener.hpp"
#import "fit_sport_mesg.hpp"
#import "fit_sport_mesg_listener.hpp"
#import "fit_three_d_sensor_calibration_mesg.hpp"
#import "fit_three_d_sensor_calibration_mesg_listener.hpp"
#import "fit_timestamp_correlation_mesg.hpp"
#import "fit_timestamp_correlation_mesg_listener.hpp"
#import "fit_totals_mesg.hpp"
#import "fit_totals_mesg_listener.hpp"
#import "fit_training_file_mesg.hpp"
#import "fit_training_file_mesg_listener.hpp"
#import "fit_unicode.hpp"
#import "fit_user_profile_mesg.hpp"
#import "fit_user_profile_mesg_listener.hpp"
#import "fit_video_clip_mesg.hpp"
#import "fit_video_clip_mesg_listener.hpp"
#import "fit_video_description_mesg.hpp"
#import "fit_video_description_mesg_listener.hpp"
#import "fit_video_frame_mesg.hpp"
#import "fit_video_frame_mesg_listener.hpp"
#import "fit_video_mesg.hpp"
#import "fit_video_mesg_listener.hpp"
#import "fit_video_title_mesg.hpp"
#import "fit_video_title_mesg_listener.hpp"
#import "fit_watchface_settings_mesg.hpp"
#import "fit_watchface_settings_mesg_listener.hpp"
#import "fit_weather_alert_mesg.hpp"
#import "fit_weather_alert_mesg_listener.hpp"
#import "fit_weather_conditions_mesg.hpp"
#import "fit_weather_conditions_mesg_listener.hpp"
#import "fit_weight_scale_mesg.hpp"
#import "fit_weight_scale_mesg_listener.hpp"
#import "fit_workout_mesg.hpp"
#import "fit_workout_mesg_listener.hpp"
#import "fit_workout_session_mesg.hpp"
#import "fit_workout_session_mesg_listener.hpp"
#import "fit_workout_step_mesg.hpp"
#import "fit_workout_step_mesg_listener.hpp"
#import "fit_zones_target_mesg.hpp"
#import "fit_zones_target_mesg_listener.hpp"
