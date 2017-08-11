//
//  FinancialActivityTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "FinancialActivityTableViewController.h"
#import "SurveyWorkflowManager.h"

@interface FinancialActivityTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLbl;
@property (weak, nonatomic) IBOutlet UIImageView *noCheckmark;
@property (weak, nonatomic) IBOutlet UILabel *yesLbl;
@property (weak, nonatomic) IBOutlet UIImageView *yesCheckmark;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSString *question;

@end

@implementation FinancialActivityTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
    [self updateCheckmarks];
    [self updateNextButtonState];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.noLbl.text = NSLocalizedString(@"FinancialActivityHasNotPreviouslyCommitted", nil);
    self.yesLbl.text = NSLocalizedString(@"FinancialActivityHasPreviouslyCommitted", nil);
    self.question = NSLocalizedString(@"FinancialActivityQuestion", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_FinancialActivity];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
}

- (IBAction)cancelSurveyButton:(id)sender
{
    [SurveyWorkflowManager clearSurvey:self.survey];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender
{
    NSLog(@"Selected choice: %@", [self.survey.hasFinancialExperience isEqual:@(YES)] ? @"Yes" : @"No");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_FinancialActivity];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.question;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

static const int yesCell = 0;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.survey.hasFinancialExperience = indexPath.row == yesCell ? @(NO) : @(YES);
    [self updateCheckmarks];
    [self updateNextButtonState];
}

- (void) updateCheckmarks
{
    self.yesCheckmark.hidden = ![self.survey.hasFinancialExperience isEqual:@(YES)];
    self.noCheckmark.hidden = ![self.survey.hasFinancialExperience isEqual:@(NO)];
}

- (void) updateNextButtonState
{
    if(!self.yesCheckmark.hidden || !self.noCheckmark.hidden)
    {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    }
    else
    {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor grayColor];
    }
}

@end
