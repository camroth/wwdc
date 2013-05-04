//
//  PanelHelper.m
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "PanelHelper.h"

@implementation PanelHelper

+ (NSString *)nameOfViewForAdjective:(NSString *)adjective
{
	return [NSString stringWithFormat:@"%@View", [adjective stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

+ (UIView *)panelForAdjective:(NSString *)adjective forOwner:(id)owner
{
	NSString *nibName = [self nameOfViewForAdjective:adjective];
	UIView *view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:0];
	[FontHelper applyLabelStylingToArrayOfObjects:[view subviews]];
	return view;
}

+ (NSArray *)panelsForOwner:(id)owner
{
	NSMutableArray *temporaryPanels = [@[] mutableCopy];
	
	NSArray *words = [Settings adjectivesToUse];
	int numberOfWords = [words count];
	
	for (int number = 0; number < numberOfWords; number++) {
		NSString *adjective = [words objectAtIndex:number];
		UIView *panel = [self panelForAdjective:adjective forOwner:owner];
		[temporaryPanels addObject:panel];
	}
	return [NSArray arrayWithArray:temporaryPanels];
}

+ (float)panelWidth
{
	return 1024.0f;
}

@end
