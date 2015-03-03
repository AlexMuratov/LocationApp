//
//  Common.m
//  LocationApp
//
//  Created by Alexander Muratov on 02.03.15.
//  Copyright (c) 2015 Alexander Muratov. All rights reserved.
//

#import "Common.h"
#import <UIKit/UIKit.h>

@implementation Common

+ (Common *)sharedInstance {
	static Common *_sharedInstance = nil;
	
	static dispatch_once_t oncePredicate;
	
	dispatch_once(&oncePredicate, ^{
		_sharedInstance = [[Common alloc] init];
	});
		
	return _sharedInstance;
}

- (void)showErrorAlert {
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
														 message:@"В настоящий момент сервис недоступен. Повторите попытку позже"
														delegate:self
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[errorAlert show];
}

@end
