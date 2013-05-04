//
//  PanelHelper.h
//  WWDC
//
//  Created by Cameron Roth on 13-04-30.
//  Copyright (c) 2013 Cameron Roth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PanelHelper : NSObject

+ (NSString *)nameOfViewForAdjective:(NSString *)adjective;
+ (UIView *)panelForAdjective:(NSString *)adjective forOwner:(id)owner;
+ (NSArray *)panelsForOwner:(id)owner;
+ (float)panelWidth;

@end
