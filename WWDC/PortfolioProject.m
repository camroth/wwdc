//
//  PortfolioProject.m
//  WWDC
//
//  Created by Cameron Roth on 13-05-01.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "PortfolioProject.h"

@implementation PortfolioProject

+ (NSAttributedString *)attributedTextForString:(NSString *)string
{
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:2.0];
	return [[NSAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName: paragraphStyle}];
}

- (void)configureWithTitle:(NSString *)title technologies:(NSString *)technologies details:(NSString *)details image:(NSString *)imageName
{	
	[self.titleLabel setText:title];
	[self.technologyLabel setAttributedText:[PortfolioProject attributedTextForString:technologies]];
	[self.detailLabel setAttributedText:[PortfolioProject attributedTextForString:details]];
	[self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"cap-%@", imageName]]];
	
	[self setUpLabels];
}

- (void)setUpLabels
{
	[self applyLabelChangesTo:[self subviews]];
}

- (void)applyLabelChangesTo:(NSArray *)objects
{
	NSArray *fonts = @[ kRalewayRegular, kRalewaySemiBold, kRalewayBold ];
	
	for (id subview in objects) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			[label setFont:[UIFont fontWithName:[fonts objectAtIndex:label.tag] size:label.font.pointSize]];
			[label setTextColor:[UIColor whiteColor]];
		} else if ([subview isKindOfClass:[UIView class]]) {
			[self applyLabelChangesTo:[subview subviews]];
		}
	}
}

@end
