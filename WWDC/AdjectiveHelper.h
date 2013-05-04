//
//  AdjectiveHelper.h
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdjectiveHelper : NSObject

+ (UIColor *)colorForAdjective:(NSString *)adjective;
+ (UILabel *)labelForAdjective:(NSString *)adjective withColor:(UIColor *)color numberInSequence:(int)number;
+ (NSArray *)adjectiveLabels;
+ (float)adjectiveLabelHeight;

@end
