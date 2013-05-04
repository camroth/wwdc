//
//  FontHelper.m
//  WWDC
//
//  Created by Cameron Roth on 13-05-01.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "FontHelper.h"

@implementation FontHelper

+ (void)applyLabelStylingToArrayOfObjects:(NSArray *)objects
{
	NSArray *fonts = @[ kRalewayExtraLight, kRalewayLight, kRalewayRegular, kRalewayMedium, kRalewaySemiBold, kRalewayBold ];
	
	for (id subview in objects) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			[label setFont:[UIFont fontWithName:[fonts objectAtIndex:label.tag] size:label.font.pointSize]];
			[label setTextColor:[UIColor whiteColor]];
		} else if ([subview isKindOfClass:[UIView class]]) {
			[self applyLabelStylingToArrayOfObjects:[subview subviews]];
		}
	}
}

@end
