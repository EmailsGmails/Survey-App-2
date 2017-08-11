//
//  ProfessionalClientStatusTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "ProfessionalClientStatusTableViewController.h"
#import "SurveyWorkflowManager.h"

@interface ProfessionalClientStatusTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noCheckmark;
@property (weak, nonatomic) IBOutlet UILabel *yesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yesCheckmark;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSString *question;

@end

@implementation ProfessionalClientStatusTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
    [self updateCheckmarks];
    [self updateNextButtonState];
}

- (void)localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.noLabel.text = NSLocalizedString(@"No", nil);
    self.yesLabel.text = NSLocalizedString(@"Yes", nil);
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_ProfessionalClientStatus];
    self.question = NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
}

- (IBAction)cancelSurveyButton:(id)sender
{
    [SurveyWorkflowManager clearSurvey:self.survey];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender
{
    NSLog(@"Selected choice: %@", [self.survey.isProfessionalClient isEqual:@(YES)] ? @"Yes" : @"No");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_ProfessionalClientStatus];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.question;
}

static const int yesCell = 0;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.survey.isProfessionalClient = indexPath.row == yesCell ? @(NO) : @(YES);
    [self updateCheckmarks];
    [self updateNextButtonState];
}

- (void) updateCheckmarks
{
    self.yesCheckmark.hidden = ![self.survey.isProfessionalClient isEqual:@(YES)];
    self.noCheckmark.hidden = ![self.survey.isProfessionalClient isEqual:@(NO)];
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
