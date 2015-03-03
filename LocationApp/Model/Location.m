//
//  Location.m
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize formattedAddress,
			coordinate,
			_id,
			name,
			placeId,
			visitingTime;

- (id)init {
	if (self = [super init]) {
		formattedAddress = @"";
		coordinate = [[Coordinate alloc] init];
		_id = @"";
		name = @"";
		placeId = @"";
		visitingTime = [[NSDate alloc] init];
	}
	
	return self;
}

- (void)setDateForString:(NSString *)dateString {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	visitingTime = [dateFormatter dateFromString:dateString];
}

- (NSString *)timeStringForDate {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	return [dateFormatter stringFromDate:visitingTime];
}

@end
