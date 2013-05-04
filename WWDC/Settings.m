//
//  Settings.m
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "Settings.h"

@implementation Settings

#pragma mark - Adjectives for "Cam Roth the..."

+ (NSArray *)adjectivesToUse
{
	return @[
		@"Individual",
		@"Student",
		@"Software Engineer",
		@"Designer",
		@"Hustler",
		@"Computer Scientist",
		@"Legend"
	];
}

+ (NSDictionary *)matchingColors
{
	return @{
		@"Individual":			kRedColor,
		@"Student":				kOrangeColor,
		@"Software Engineer":	kYellowColor,
		@"Designer":			kGreenColor,
		@"Hustler":				kBlueColor,
		@"Computer Scientist":	kIndigoColor,
		@"Legend":				kVioletColor
	};
}

@end
