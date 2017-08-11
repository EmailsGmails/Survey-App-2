//
//  QuestionTableViewCell.h
//  SurveyApp
//
//  Created by Emils on 26.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UIImageView *checkmark;

@end
