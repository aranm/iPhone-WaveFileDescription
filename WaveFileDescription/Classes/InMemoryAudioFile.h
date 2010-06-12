//
//  InMemoryAudioFile.h
//  HelloWorld
//
//  Created by Aran Mulholland on 22/02/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioFile.h>
#include <sys/time.h>


@interface InMemoryAudioFile : NSObject {
	AudioStreamBasicDescription		mDataFormat;                    
    AudioFileID						mAudioFile;                     
    UInt32							bufferByteSize;                 
    SInt64							mCurrentPacket;                 
    UInt32							mNumPacketsToRead;              
	SInt64							tempPacketCount;
	SInt64							packetCount;
	UInt32							*audioData;
	Boolean							isPlaying;
	NSString						*filePathName;
	Boolean							isReadingAudioFile;
	Boolean							isFillingBuffer;
	NSString						*wavFileName;
}

@property (nonatomic) Boolean isPlaying;
@property (nonatomic) SInt64 packetCount;
@property (nonatomic, retain)NSString *filePathName;
@property (nonatomic, retain)NSString *wavFileName;
@property (nonatomic)UInt32 *audioData;
//@property (nonatomic, retain)NSString *fileName;
//opens a wav file
-(OSStatus)open:(NSString *)filePath;
//gets the info about a wav file, stores it locally
-(OSStatus)getFileInfo;
//fills buffer with nuberOfPackets from the audio file, starting at index, returns number of samples put in buffer
-(UInt32)fillAudioBuffer:(UInt32 *)buffer fromBufferIndex:(UInt32)index numberOfPackets:(UInt32)numberPackets;

-(NSString *)getSampleSummary;
@end
