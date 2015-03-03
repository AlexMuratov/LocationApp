//
//  Coordinate.h
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject
{
	double lattitude;
	double longitude;
}

@property (nonatomic, assign) double lattitude;
@property (nonatomic, assign) double longitude;

@end
