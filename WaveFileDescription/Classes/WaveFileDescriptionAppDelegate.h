//
//  WaveFileDescriptionAppDelegate.h
//  WaveFileDescription
//
//  Created by arab on 12/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaveFileDescriptionViewController;

@interface WaveFileDescriptionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WaveFileDescriptionViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WaveFileDescriptionViewController *viewController;

@end

