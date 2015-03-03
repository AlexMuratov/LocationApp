//
//  Location.h
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Location : NSObject
{
	NSString *formattedAddress;
	Coordinate *coordinate;
	NSString *_id;
	NSString *name;
	NSString *placeId;
	NSDate *visitingTime;
}

@property (nonatomic, retain) NSString *formattedAddress;
@property (nonatomic, retain) Coordinate *coordinate;
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *placeId;
@property (nonatomic, retain) NSDate *visitingTime;

- (void)setDateForString:(NSString *)dateString;
- (NSString *)timeStringForDate;

@end
