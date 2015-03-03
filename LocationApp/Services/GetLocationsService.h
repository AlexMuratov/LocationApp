//
//  GetLocationsService.h
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetLocationsServiceDelegate

- (void)getLocationsWithArray:(NSArray *)array;
- (void)getLocationsWithError:(NSError *)error;

@end

@interface GetLocationsService : NSObject {
	__weak id <GetLocationsServiceDelegate> delegate;
}

@property (nonatomic, weak) id <GetLocationsServiceDelegate> delegate;

- (void)getLocations;

@end
