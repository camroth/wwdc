//
//  AdjectiveHelper.m
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "AdjectiveHelper.h"

@implementation AdjectiveHelper

#pragma mark - Label Creation helpers

+ (UIColor *)colorForAdjective:(NSString *)adjective
{
	return [[Settings matchingColors] objectForKey:adjective];
}

+ (UILabel *)labelForAdjective:(NSString *)adjective withColor:(UIColor *)color numberInSequence:(int)number
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 800, 100)];
	[label setFont:[UIFont fontWithName:kPermanentMarker size:60.0f]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setText:adjective];
	[label setTextColor:color];
	[label sizeToFit];
	[label setFrame:CGRectMake(0, 0, label.frame.size.width + 20, label.frame.size.height)];
	return label;
}

+ (NSArray *)adjectiveLabels
{
	NSMutableArray *temporaryAdjectives = [@[] mutableCopy];
	
	NSArray *words = [Settings adjectivesToUse];
	int numberOfWords = [words count];
	
	for (int number = 0; number < numberOfWords; number++) {
		NSString *adjective = [words objectAtIndex:number];
		UIColor *color = [self colorForAdjective:adjective];
		UILabel *label = [self labelForAdjective:adjective withColor:color numberInSequence:number];
		[temporaryAdjectives addObject:label];
	}
	return [NSArray arrayWithArray:temporaryAdjectives];
}

+ (float)adjectiveLabelHeight
{
	return 70.0f;
}

@end
