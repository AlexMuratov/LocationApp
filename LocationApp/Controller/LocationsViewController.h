//
//  ViewController.h
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GetLocationsService.h"

@interface LocationsViewController : UIViewController <GMSMapViewDelegate, GetLocationsServiceDelegate>
{
	NSArray *locationsArray;
	
	IBOutlet UIView *loadingView;
}


@end

