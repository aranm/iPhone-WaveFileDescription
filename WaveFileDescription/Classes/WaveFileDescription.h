//
//  WaveFileDescription.h
//  WaveFileDescription
//
//  Created by arab on 12/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioFile.h>


@interface WaveFileDescription : NSObject {

}

-(OSStatus)getDetails:(NSString *)completeFilePathAndName;

@end
