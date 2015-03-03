//
//  Common.h
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Services
#define SERVICE_URL_STRING @"http://www.xtc.vc/"
#define SERVICE_GET_LOCATIONS @"fake/markers.json"

#pragma mark - Get Locations Service Parsing
#define MARKERS @"markers"
#define ADDRESS @"formatted_address"
#define COORDINATES @"coordinates"
#define LATTITUDE @"lat"
#define LONGITUDE @"lng"
#define ID @"id"
#define NAME @"name"
#define PLACE_ID @"place_id"
#define VISITING_TIME @"visiting_time"

#pragma mark - UI Main Preferences
#define LOADING_VIEW_CORNER_RADIUS 5

#pragma mark - Google Maps
#define GOOGLE_MAPS_API_KEY @"AIzaSyCA0SjDwcbrP4GfiLdr5g2X6z3xUNKs-60"

#pragma mark - Colors
#define GENERAL_STYLE_COLOR [UIColor colorWithRed:0.0392f green:0.2706f blue:0.3333f alpha:1]


@interface Common : NSObject

+ (Common *)sharedInstance;
- (void)showErrorAlert;

@end
