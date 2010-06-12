//
//  InMemoryAudioFile.m
//  HelloWorld
//
//  Created by Aran Mulholland on 22/02/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import "InMemoryAudioFile.h"

@implementation InMemoryAudioFile
@synthesize isPlaying;
@synthesize filePathName;
@synthesize packetCount;
@synthesize audioData;
@synthesize wavFileName;

//overide init method
- (id)init 
{ 
    self = [super init]; 
	isReadingAudioFile = NO;
	isFillingBuffer = NO;
	return self;
}

//open and read a wav file
-(OSStatus)open:(NSString *)wavInputFileName{
	
	[self setWavFileName:wavInputFileName];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:wavInputFileName ofType:@"wav" inDirectory:@"SampleLibrary"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:filePath] == false){	
		//if we are loading an old file load a default sample
		filePath = [[NSBundle mainBundle] pathForResource:@"standard_kick" ofType:@"wav" inDirectory:@"SampleLibrary"];
		[self setWavFileName:@"standard_kick"];
	}
	
	UInt32 *tempAudioData;
	
	//get a ref to the audio file, need one to open it
	CFURLRef audioFileURL = CFURLCreateFromFileSystemRepresentation (NULL, (const UInt8 *)[filePath cStringUsingEncoding:[NSString defaultCStringEncoding]] , strlen([filePath cStringUsingEncoding:[NSString defaultCStringEncoding]]), false);
	
	//open the audio file
	OSStatus result = AudioFileOpenURL (audioFileURL, 0x01, 0, &mAudioFile);
	//were there any errors reading? if so deal with them first
	if (result != noErr) {
		tempPacketCount = -1;
	}
	//otherwise
	else{
		//get the file info
		[self getFileInfo];
		//how many packets read? (packets are the number of stereo samples in this case)
		
		UInt32 packetsRead = tempPacketCount;
		OSStatus result = -1;
		
		UInt32 numBytesRead = -1;
		//if we didn't get any packets dop nothing, nothing to read
		if (tempPacketCount <= 0) { }
		//otherwise fill our in memory audio buffer with the whole file (i wouldnt use this with very large files btw)
		else{
			//allocate the buffer
			tempAudioData = (UInt32 *)malloc(sizeof(UInt32) * tempPacketCount);
			//read the packets
			result = AudioFileReadPackets (mAudioFile, false, &numBytesRead, NULL, 0, &packetsRead,  tempAudioData); 
		}
		if (result==noErr){
			
			//do all the final copying
			while(isFillingBuffer == YES){}
			//set our flag
			isReadingAudioFile = YES;
			audioData = tempAudioData;
			packetCount = tempPacketCount;
			[self setFilePathName:filePath];
			
			isReadingAudioFile = NO;
		}
	}
	
	CFRelease (audioFileURL);     
	//close the audio file
	AudioFileClose(mAudioFile);
	
	//[pool release];
	
	return result;
}


- (OSStatus) getFileInfo {
	
	OSStatus result = -1;
	
	if (mAudioFile == nil){}
	else{
		UInt32 dataSize = sizeof tempPacketCount;
		result = AudioFileGetProperty(mAudioFile, kAudioFilePropertyAudioDataPacketCount, &dataSize, &tempPacketCount);
		if (result==noErr) { }
		else{
			tempPacketCount = -1;
		}
	}
	return result;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(UInt32)fillAudioBuffer:(UInt32 *)buffer fromBufferIndex:(UInt32)index numberOfPackets:(UInt32)numberPackets{
	
	UInt32 packetsCopied = 0;
	
	isFillingBuffer = YES;
	while (packetsCopied < numberPackets && index < packetCount && isReadingAudioFile == NO){
		buffer[packetsCopied++] = audioData[index++];
	}
	isFillingBuffer = NO;
	
	//return the amount of packets copied
	return packetsCopied;
}


-(NSString *)getSampleSummary{
	
	return wavFileName;
}


- (void)dealloc {
	//close the audio file, should be closed unless we
	//app-exit in the middle of a file read
	AudioFileClose(mAudioFile);
	[wavFileName release];
	[filePathName release];
	free(audioData);
	[super dealloc];
}


@end
