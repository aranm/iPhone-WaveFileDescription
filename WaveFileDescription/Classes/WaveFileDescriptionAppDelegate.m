//
//  WaveFileDescriptionAppDelegate.m
//  WaveFileDescription
//
//  Created by arab on 12/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WaveFileDescriptionAppDelegate.h"
#import "WaveFileDescriptionViewController.h"
#import "WaveFileDescription.h"

@implementation WaveFileDescriptionAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sampleOne" ofType:@"wav"];

	WaveFileDescription *waveFileDescription = [[WaveFileDescription alloc] init];
	[waveFileDescription getDetails:filePath];
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
