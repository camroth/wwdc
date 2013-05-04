//
//  MainViewController.h
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate> {
	float _pageSizeOfAdjectiveLabel;
	float _widthOfPanel;
}

@property (nonatomic, strong) IBOutlet UIScrollView *panelsScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *adjectivesScrollView;
@property (nonatomic, strong) IBOutlet UILabel *header;
@property (nonatomic, strong) NSArray *adjectives;
@property (nonatomic, strong) NSArray *panels;
@property (nonatomic, strong) UIScrollView *projectsScrollView;
@property (nonatomic, strong) UIButton *projectsPrevious;
@property (nonatomic, strong) UIButton *projectsNext;
@property (nonatomic, strong) UIPageControl *pageControl;

- (void)addAndLayoutAdjectiveLabels;
- (void)addAndLayoutPanels;

- (void)getReferencesToPortfolioObjects;
- (void)populatePortfolio;

- (int)currentPortfolioPage;
- (void)nextProject;
- (void)previousProject;
- (void)scrollProjectsToPage:(int)page;
- (void)updatePortfolioButtons;

@end
