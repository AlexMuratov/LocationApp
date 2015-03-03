//
//  Coordinate.m
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate
@synthesize lattitude,
			longitude;

- (id)init {
	if (self = [super init]) {
		lattitude = 0;
		longitude = 0;
	}
	return self;
}

@end
