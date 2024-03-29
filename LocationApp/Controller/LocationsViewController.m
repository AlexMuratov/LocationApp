//
//  ViewController.m
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import "LocationsViewController.h"
#import "Common.h"
#import "Location.h"
#import <GoogleMaps/GoogleMaps.h>

#define MAP_ZOOM_LEVEL 0
#define MARKER_FRAME CGRectMake(0, 0, 64, 32)
#define MARKER_LABEL_FRAME CGRectMake(0, 0, 64, 23)

@interface LocationsViewController ()

@end

@implementation LocationsViewController {
	GMSMapView *mapView_;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	locationsArray = [[NSArray alloc] init];
	
	// Настраиваем вьюшку с индикатором загрузки
	[loadingView.layer setCornerRadius:LOADING_VIEW_CORNER_RADIUS];
	[loadingView.layer setMasksToBounds:YES];
	
	// Получаем список объектов
	GetLocationsService *getLocationsService = [[GetLocationsService alloc] init];
	[getLocationsService setDelegate:self];
	[getLocationsService getLocations];
	[loadingView setAlpha:1];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSArray *)sortArray:(NSMutableArray *)array ByKey:(NSString *)key {
	NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:array];
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
												 ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	[sortedArray setArray:[sortedArray sortedArrayUsingDescriptors:sortDescriptors]];
	return sortedArray;
}

- (UIImage *)imageFromView:(UIView *) view
{
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(view.frame.size);
	}
	[view.layer renderInContext: UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)setMapPoints {
	GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];

	for (Location *location in locationsArray) {
		GMSMarker *marker = [[GMSMarker alloc] init];
		
		UIView *view = [[UIView alloc] initWithFrame:MARKER_FRAME];
		UIImageView *pinImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_marker"]];
		UILabel *label = [[UILabel alloc] initWithFrame:MARKER_LABEL_FRAME];
		label.text = [location timeStringForDate];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentCenter;
		
		[view addSubview:pinImageView];
		[view addSubview:label];
	
		UIImage *markerIcon = [self imageFromView:view];
		marker.icon = markerIcon;
		marker.title = location.name;
		marker.infoWindowAnchor = CGPointMake(0.5, 0.0);
		marker.position = CLLocationCoordinate2DMake(location.coordinate.lattitude, location.coordinate.longitude);
		bounds = [bounds includingCoordinate:marker.position];
		marker.map = mapView_;
	}
	
	// Реализация масштабирования карты так, чтобы было видно все маркеры
	[mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
}

- (void)setMapPolyline {
	GMSMutablePath *path = [GMSMutablePath path];
	
	NSMutableArray *sortedLocationArray = [[NSMutableArray alloc] initWithArray:locationsArray];
	[sortedLocationArray setArray:[self sortArray:sortedLocationArray ByKey:@"visitingTime"]];
	
	for (Location *location in sortedLocationArray) {
		[path addCoordinate:CLLocationCoordinate2DMake(location.coordinate.lattitude, location.coordinate.longitude)];
	}
	GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
	[polyline setStrokeColor:GENERAL_STYLE_COLOR];
	NSArray *styles = @[[GMSStrokeStyle solidColor:GENERAL_STYLE_COLOR],
						[GMSStrokeStyle solidColor:[UIColor clearColor]]];
	NSArray *lengths = @[@80, @80];
	polyline.spans = GMSStyleSpans(polyline.path, styles, lengths, kGMSLengthGeodesic);
	polyline.map = mapView_;
}

#pragma mark - GetLocationsService Delegate
- (void)getLocationsWithArray:(NSArray *)array {
	[loadingView setAlpha:0];
	
	if (array) {
		locationsArray = array;
		
		// За стартовую точку принимаем первую точку
		Coordinate *coordinate = ((Location *)[locationsArray objectAtIndex:0]).coordinate;
		
		// Инициализируем карту
		GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.lattitude
																longitude:coordinate.longitude
																	 zoom:MAP_ZOOM_LEVEL];
		mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
		
		mapView_.myLocationEnabled = YES;
		self.view = mapView_;
		
		// Расставляем маркеры на карте
		[self setMapPoints];
		// Рисуем путь на карте
		[self setMapPolyline];
	}
	else {
		[[Common sharedInstance] showErrorAlert];
	}
}

- (void)getLocationsWithError:(NSError *)error {
	[loadingView setAlpha:0];
	NSLog(@"Get locations service error: %@", error);
	
	[[Common sharedInstance] showErrorAlert];
}

@end
