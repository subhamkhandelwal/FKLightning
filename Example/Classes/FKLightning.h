//
//  FKLightning.h
//  FKLightning
//
//  Created by subham khandelwal on 23/07/15.
//  Copyright (c) 2015 Subham Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKLightning : NSObject

@property (assign, nonatomic) double weightedInternetSpeed;

// A good internet speed can be anything based on your usecase. Ideally, it should be kept at 50.
@property (assign, nonatomic) double goodInternetSpeed;

// Minimum size to calculate speed should be a non-zero value.
// Only if speed is above this value FKLightning will calculate weighted interet speed.
// Ideal value assigned should be 30000. Again, it depends on your usecase.
// If this value is 0 then this library won't be used.
@property (assign, nonatomic) double minSizeToCalculateSpeed;

//@property (assign, nonatomic) NSInteger resetDataAfterXCalls;

+ (FKLightning *) sharedInstance;
- (void) calculateWtInternetSpeedWithCurrentSize: (double)lightningBytes andCurrentTimeTaken: (double)lightningTime;
- (void) resetData;
- (NSString *) getNetoworkTypeWithDetectedNetwork: (NSString *)networkType;

@end
