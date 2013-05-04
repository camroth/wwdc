//
//  MainViewController.m
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import "MainViewController.h"
#import "AdjectiveHelper.h"
#import "PanelHelper.h"
#import "PortfolioProject.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_pageSizeOfAdjectiveLabel = [AdjectiveHelper adjectiveLabelHeight];
	_widthOfPanel = [PanelHelper panelWidth];
	
	[self.header setFont:[UIFont fontWithName:kRalewayExtraLight size:self.header.font.pointSize]];
	
	[self addAndLayoutAdjectiveLabels];
	[self addAndLayoutPanels];
	
	[self.adjectivesScrollView setContentOffset:CGPointMake(0, self.adjectivesScrollView.contentSize.height - _pageSizeOfAdjectiveLabel) animated:YES];
	
	[UIView animateWithDuration:1.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.adjectivesScrollView setContentOffset:CGPointZero];
	} completion:nil];
	
	[self getReferencesToPortfolioObjects];
	[self updatePortfolioButtons];
	[self populatePortfolio];
}

- (void)addAndLayoutAdjectiveLabels
{
	self.adjectives = [AdjectiveHelper adjectiveLabels];
	
	float offset = 0;
	for (UILabel *label in self.adjectives) {
		CGRect frame = label.frame;
		[label setFrame:CGRectMake(18, offset, frame.size.width, [AdjectiveHelper adjectiveLabelHeight])];
		[self.adjectivesScrollView addSubview:label];
		offset += label.frame.size.height;
		[self.adjectivesScrollView setContentSize:CGSizeMake(self.adjectivesScrollView.frame.size.width, offset)];
	}
}

- (void)addAndLayoutPanels
{
	self.panels = [PanelHelper panelsForOwner:self];
	
	float offset = 0;
	for (UIView *panel in self.panels) {
		CGRect frame = panel.frame;
		[panel setFrame:CGRectMake(offset, 0, frame.size.width, frame.size.height)];
		[self.panelsScrollView addSubview:panel];
		offset += panel.frame.size.width;
		[self.panelsScrollView setContentSize:CGSizeMake(offset, self.panelsScrollView.frame.size.height)];
	}
	
	UIView *redBuffer = [[UIView alloc] initWithFrame:CGRectMake(-_widthOfPanel, 0, _widthOfPanel, 620)];
	[redBuffer setBackgroundColor:kRedColor];
	[self.panelsScrollView addSubview:redBuffer];
	
	UIView *violetBuffer = [[UIView alloc] initWithFrame:CGRectMake(offset, 0, _widthOfPanel, 620)];
	[violetBuffer setBackgroundColor:kVioletColor];
	[self.panelsScrollView addSubview:violetBuffer];
}

- (void)getReferencesToPortfolioObjects
{
	UIScrollView *view = (UIScrollView *)[self.panelsScrollView viewWithTag:kProjectHighlightsTag];
	[view setContentSize:CGSizeMake(view.frame.size.width, 1300)];
	
	self.projectsScrollView = (UIScrollView *)[self.panelsScrollView viewWithTag:kProjectsScrollViewTag];
	self.projectsScrollView.delegate = self;
	self.projectsPrevious = (UIButton *)[self.panelsScrollView viewWithTag:kProjectsPreviousTag];
	self.projectsNext = (UIButton *)[self.panelsScrollView viewWithTag:kProjectsNextTag];
	self.pageControl = (UIPageControl *)[self.panelsScrollView viewWithTag:kProjectsPageControlTag];
	
	[self.projectsPrevious addTarget:self action:@selector(previousProject) forControlEvents:UIControlEventTouchUpInside];
	[self.projectsNext addTarget:self action:@selector(nextProject) forControlEvents:UIControlEventTouchUpInside];
}

- (void)populatePortfolio
{
	NSArray *allProjects = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Projects" ofType:@"plist"]];
	for (NSDictionary *projectInfo in allProjects) {
		PortfolioProject *project = [[[NSBundle mainBundle] loadNibNamed:@"PortfolioProject" owner:self options:nil] objectAtIndex:0];
		[project configureWithTitle:projectInfo[@"title"] technologies:projectInfo[@"tech"] details:projectInfo[@"details"] image:projectInfo[@"image"]];
		[self.projectsScrollView addSubview:project];
	}
	
	float offset = 0;
	float height = 0;
	for (PortfolioProject *project in [self.projectsScrollView subviews]) {
		CGRect frame = project.frame;
		height = frame.size.height;
		[project setFrame:CGRectMake(offset, 0, frame.size.width, frame.size.height)];
		offset += project.frame.size.width;
		[self.projectsScrollView setContentSize:CGSizeMake(offset, self.projectsScrollView.frame.size.height)];
	}
}

- (void)nextProject
{
	int page = [self currentPortfolioPage];
	if (page < [self.pageControl numberOfPages] - 1) page++;
	
	[self scrollProjectsToPage:page];
}

- (void)previousProject
{
	int page = [self currentPortfolioPage];
	if (page > 0) page--;
	
	[self scrollProjectsToPage:page];
}

- (void)scrollProjectsToPage:(int)page
{
	[self.projectsScrollView setContentOffset:CGPointMake(page * _widthOfPanel, 0) animated:YES];
	[self.pageControl setCurrentPage:page];
	[self updatePortfolioButtons];
}

- (int)currentPortfolioPage
{
	return [self.pageControl currentPage];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == self.adjectivesScrollView) {
		float sizeOfPage = _pageSizeOfAdjectiveLabel;
		
		float page = scrollView.contentOffset.y / sizeOfPage;
		if (page < -1) page = -1;
		if (page >= [self.panels count]) page = [self.panels count];
		
		[self.panelsScrollView setDelegate:nil];
		[self.panelsScrollView setContentOffset:CGPointMake(page * _widthOfPanel, 0)];
		[self.panelsScrollView setDelegate:self];
	}
	
	if (scrollView == self.panelsScrollView) {
		float sizeOfPage = _widthOfPanel;
		
		float page = scrollView.contentOffset.x / sizeOfPage;
		if (page < -1) page = -1;
		if (page >= [self.panels count]) page = [self.panels count];
		
		[self.adjectivesScrollView setDelegate:nil];
		[self.adjectivesScrollView setContentOffset:CGPointMake(0, page * _pageSizeOfAdjectiveLabel)];
		[self.adjectivesScrollView setDelegate:self];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (scrollView == self.projectsScrollView) {
		int page = floorf(self.projectsScrollView.contentOffset.x / _widthOfPanel);
		
		if (page < 0) page = 0;
		if (page >= [self.pageControl numberOfPages] - 1) page = [self.pageControl numberOfPages] - 1;
		
		[self.pageControl setCurrentPage:page];
		[self updatePortfolioButtons];
	}
}

- (void)updatePortfolioButtons
{
	[self.projectsPrevious setEnabled:YES];
	[self.projectsNext setEnabled:YES];
	int page = [self currentPortfolioPage];
	if (page == 0) {
		[self.projectsPrevious setEnabled:NO];
	}
	if (page == [self.pageControl numberOfPages] - 1) {
		[self.projectsNext setEnabled:NO];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
