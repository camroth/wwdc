//
//  PortfolioProject.h
//  WWDC
//
//  Created by Cameron Roth on 13-05-01.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortfolioProject : UIView

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *technologyLabel;
@property (nonatomic, strong) IBOutlet UILabel *detailLabel;

+ (NSAttributedString *)attributedTextForString:(NSString *)string;
- (void)configureWithTitle:(NSString *)title technologies:(NSString *)technologies details:(NSString *)details image:(NSString *)imageName;
- (void)setUpLabels;
- (void)applyLabelChangesTo:(NSArray *)objects;

@end
