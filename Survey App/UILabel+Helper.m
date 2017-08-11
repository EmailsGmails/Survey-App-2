//
//  UILabel+Helper.m
//  SurveyApp
//
//  Created by Emils on 20.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    self.font = [UIFont fontWithName:name size:self.font.pointSize]; }
@end
