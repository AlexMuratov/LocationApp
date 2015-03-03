//
//  GetLocationsService.m
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import "GetLocationsService.h"
#import "Common.h"
#import "Location.h"
#import "Coordinate.h"

@implementation GetLocationsService
@synthesize delegate;

- (void)getLocations {
	NSString *requestBodyString = [NSString stringWithFormat:@"%@%@", SERVICE_URL_STRING, SERVICE_GET_LOCATIONS];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestBodyString]];
	[request setHTTPMethod:@"GET"];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		NSError *error = nil;
		NSURLResponse *response = nil;
		
		NSData *result = [NSURLConnection sendSynchronousRequest:request
											   returningResponse:&response
														   error:&error];
		if (!error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				NSError *jsonParsingError = nil;
				NSDictionary *dictionaryForParsing = [NSJSONSerialization JSONObjectWithData:result
																					 options:0
																					   error:&jsonParsingError];
				if (!jsonParsingError) {
					[self getLocationsFromArray:[dictionaryForParsing objectForKey:MARKERS]];
				}
				else {
					[delegate getLocationsWithError:jsonParsingError];
				}
			});
		}
		else {
			[delegate getLocationsWithError:error];
		}
	});
}

- (void)getLocationsFromArray:(NSArray *)array {
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [array count]; i++) {
		NSDictionary *locationObject = [array objectAtIndex:i];
		NSDictionary *coordinateObject = [locationObject objectForKey:COORDINATES];
		Location *location = [[Location alloc] init];
		Coordinate *coordinate = [[Coordinate alloc] init];
		
		location.formattedAddress = [locationObject objectForKey:ADDRESS];
		coordinate.lattitude = [[coordinateObject objectForKey:LATTITUDE] doubleValue];
		coordinate.longitude = [[coordinateObject objectForKey:LONGITUDE] doubleValue];
		location.coordinate = coordinate;
		location._id = [locationObject objectForKey:ID];
		location.name = [locationObject objectForKey:NAME];
		location.placeId = [locationObject objectForKey:PLACE_ID];
		[location setDateForString:[locationObject objectForKey:VISITING_TIME]];
		
		[resultArray addObject:location];
	}
	
	[delegate getLocationsWithArray:resultArray];
}

@end
