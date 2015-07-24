//
//  FKLightning.m
//  FKLightning
//
//  Created by subham khandelwal on 23/07/15.
//  Copyright (c) 2015 Subham Khandelwal. All rights reserved.
//

#import "FKLightning.h"

@interface FKLightning()

@property (assign, nonatomic) double weightedNumerator;
@property (assign, nonatomic) double weightedDenominator;
@property (assign, nonatomic) double maximumBytesReceived;
@property (assign, nonatomic) NSInteger totalCount;

@end

static FKLightning *lightningTest = nil;

@implementation FKLightning

+ (FKLightning *) sharedInstance {
    if (!lightningTest) {
        static dispatch_once_t pred;        // Lock
        dispatch_once(&pred, ^{             // This code is called at most once per app
            lightningTest = [[FKLightning alloc] init];
        });
    }
    return lightningTest;
}

/**
 * Provide total bytes transferred along with speed to calculate current speed and also the weighted speed in one session until app goes to background.
 */
- (void) calculateWtInternetSpeedWithCurrentSize: (double)lightningBytes andCurrentTimeTaken: (double)lightningTime
{
    @synchronized(self)
    {
        if (![self shouldCalculateSpeedWithData:lightningBytes])
            return;
        
        _totalCount++;
//        if (_totalCount != 0 && _resetDataAfterXCalls != 0 && _totalCount == _resetDataAfterXCalls)
//            [self resetData];
        
        if (_maximumBytesReceived < lightningBytes)
            _maximumBytesReceived = lightningBytes;
        
        double currentSpeed = lightningBytes/lightningTime;
        
        _weightedNumerator += lightningBytes*currentSpeed;
        _weightedDenominator += lightningBytes;
        _weightedInternetSpeed = _weightedNumerator/_weightedDenominator;
    }
}

/**
 * If the size is too less then we would get very low speed and 
 * lot of these instances would result in inaccurate weighted speed hence this limit.
 * A good value of _minSizeToCalculateSpeed is something around 30000.
 */
- (BOOL) shouldCalculateSpeedWithData: (double)dataSize
{
    if (dataSize > _minSizeToCalculateSpeed)
        return YES;
    else
        return NO;
}

/**
 * Initially when app starts the weighted avg. will be 0 which would make this class return incorrectly.
 */
- (BOOL) canUseFKLightning
{
    if (_maximumBytesReceived > _minSizeToCalculateSpeed)
        return YES;
    else
        return NO;
}

/**
 * Return the detected network type if wt.speed is above threshold. For 2g, even if the speed is greater than threshold we will show 2g quality image
 * This is done because image may be cached and we don't want to download image again.
 */
- (NSString *) getNetoworkTypeWithDetectedNetwork: (NSString *)networkType
{
    // Setting this value to 0 will turn off FKLightning.
    if (_goodInternetSpeed == 0 || ![self canUseFKLightning])
        return networkType;
    
    if (_weightedInternetSpeed >= _goodInternetSpeed)
        return networkType;
    else
        return @"2g";
}

/**
 * This method resets all the data. Ideally, this method should be called when app goes to background or app is killed.
 */
- (void) resetData
{
    _weightedNumerator = 0;
    _weightedDenominator = 0;
    _weightedInternetSpeed = 0;
    _totalCount = 0;
    _maximumBytesReceived = 0;
}

@end
