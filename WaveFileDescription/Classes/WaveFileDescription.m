//
//  WaveFileDescription.m
//  WaveFileDescription
//
//  Created by arab on 12/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WaveFileDescription.h"


@implementation WaveFileDescription

/*
@function	AudioFileGetProperty
@abstract   Copies the value for a property of an AudioFile into a buffer.
@param      inAudioFile			an AudioFileID.
@param      inPropertyID		an AudioFileProperty constant.
@param      ioDataSize			on input the size of the outPropertyData buffer. On output the number of bytes written to the buffer.
@param      outPropertyData		the buffer in which to write the property data.
@result							returns noErr if successful.

extern OSStatus
AudioFileGetProperty(	AudioFileID				inAudioFile,
					 AudioFilePropertyID		inPropertyID,
					 UInt32					*ioDataSize,
					 void					*outPropertyData)	
*/

//open and read a wav file
-(OSStatus)getDetails:(NSString *)completeFilePathAndName{
	
	OSStatus returnValue = 0;
	AudioFileID	mAudioFile;	
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:completeFilePathAndName] == false){	
		returnValue = -1;
	}
	else{
		//get a ref to the audio file, need one to open it
		CFURLRef audioFileURL = CFURLCreateFromFileSystemRepresentation (NULL, (const UInt8 *)[completeFilePathAndName cStringUsingEncoding:[NSString defaultCStringEncoding]] , strlen([completeFilePathAndName cStringUsingEncoding:[NSString defaultCStringEncoding]]), false);
		
		//open the audio file
		OSStatus result = AudioFileOpenURL (audioFileURL, 0x01, 0, &mAudioFile);	
		//release the url
		CFRelease (audioFileURL);
		if (result != noErr) {
			returnValue = -1;
		}
		//otherwise
		else{			
			
			UInt32 fileType = 0;
			//get the file info
			UInt32 dataSize = sizeof fileType;
			result = AudioFileGetProperty(mAudioFile, kAudioFilePropertyFileFormat, &dataSize, &fileType);
			
			if (fileType == kAudioFileWAVEType){
				printf("Wave File");
				
				AudioStreamBasicDescription mDataFormat;
				UInt32 dataFormatSize = sizeof (AudioStreamBasicDescription);    // 1
				
				AudioFileGetProperty (mAudioFile, kAudioFilePropertyDataFormat, &dataFormatSize, &mDataFormat);
				
				printf("Sample Rate: %f, Bit Rate: %d, Channels :%d\n", mDataFormat.mSampleRate, mDataFormat.mBitsPerChannel, mDataFormat.mChannelsPerFrame);
			}
			else{
				returnValue = -1;
			}	
			
			//close the audio file
			AudioFileClose(mAudioFile);
		}			
	}
	
	return returnValue;
}

@end
