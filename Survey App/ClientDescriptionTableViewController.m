//
//  ProfessionalClientStatusTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "ClientDescriptionTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface ClientDescriptionTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSArray *answerOptions;
@property (strong, nonatomic) NSString *question;

@end

@implementation ClientDescriptionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = @[
                           NSLocalizedString(@"ProfessionalClientDescriptionLicensed", nil),
                           NSLocalizedString(@"ProfessionalClientDescriptionCommercialCommunity", nil),
                           NSLocalizedString(@"ProfessionalClientDescriptionInvestmentCommercialCommunity", nil),
                           NSLocalizedString(@"ProfessionalClientDescriptionOther", nil)
                        ];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_ProfessionalClientDescription];
    self.question = NSLocalizedString(@"ClientDescriptionQuestion", nil);
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
    NSLog(@"Selected choice: %@", self.answerOptions[self.survey.clientDescription]);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_ProfessionalClientDescription];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.question;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"QuestionCell";
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.checkmark.hidden = indexPath.row == self.survey.clientDescription ? NO : YES;
    self.nextButton.enabled = self.survey.clientDescription >= 0 ? YES : NO;
    self.nextButton.backgroundColor = self.survey.clientDescription >= 0 ? [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0] : [UIColor grayColor];
    cell.questionLbl.text = self.answerOptions[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.answerOptions count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.survey.clientDescription = (ClientDescription)indexPath.row;
    [tableView reloadData];
}

@end
