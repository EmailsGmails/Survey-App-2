//
//  FinancialSectorPositionTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "FinancialSectorPositionTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface FinancialSectorPositionTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) NSString *questionOne;
@property (strong, nonatomic) NSString *questionTwo;
@property (strong, nonatomic) NSArray *answerOptionsHasFinancialSectorPosition;
@property (strong, nonatomic) NSArray *answerOptionsFinancialSectorPosition;
@property (strong, nonatomic) NSArray *answerOptions;

@end

@implementation FinancialSectorPositionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptionsHasFinancialSectorPosition = [NSArray arrayWithObjects:NSLocalizedString(@"No", nil),
                                                    NSLocalizedString(@"Yes", nil), nil];
    self.answerOptionsFinancialSectorPosition = @[
                                                  NSLocalizedString(@"FinancialSectorPositionAnalyst", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionBroker", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionPortfolioManager", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionInvestmentConsultant", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionRegulationExpert", nil)
                                            ];
    self.answerOptions = [NSArray arrayWithObjects:self.answerOptionsHasFinancialSectorPosition,
                          self.answerOptionsFinancialSectorPosition, nil];
    self.questionOne = NSLocalizedString(@"HasFinancialSectorPositionQuestion", nil);
    self.questionTwo = NSLocalizedString(@"FinancialSectorPositionQuestion", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_FinancialSectorPosition];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [SurveyWorkflowManager clearSurvey:self.survey];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %@", [self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? @"Yes" : @"No");
    if ([self.survey.hasFinancialSectorPosition isEqual:@(YES)]) {
        NSLog(@"Selected choice: %@", self.answerOptionsFinancialSectorPosition[self.survey.financialSectorPosition]);
    }
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_FinancialSectorPosition];
}

static const int firstSection = 0;
static const int secondSection = 1;
static const int yesCell = 0;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"QuestionCell";
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLbl.text = [[self.answerOptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    self.survey.financialSectorPosition = [self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? self.survey.financialSectorPosition : FinancialSectorPosition_NIL;
    if (indexPath.section == firstSection && self.survey.hasFinancialSectorPosition != nil)
    {
        cell.checkmark.hidden = ![self.survey.hasFinancialSectorPosition  isEqual: @(indexPath.row)];
        self.nextButton.enabled = ![self.survey.hasFinancialSectorPosition isEqual:@(YES)];
        self.nextButton.backgroundColor = ![self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0] : [UIColor grayColor];
    }
    else
    {
        cell.checkmark.hidden = indexPath.row == self.survey.financialSectorPosition ? NO : YES;
        self.nextButton.enabled = self.survey.financialSectorPosition >= 0 ? YES : NO;
        self.nextButton.backgroundColor = self.survey.financialSectorPosition >= 0 ? [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0] : [UIColor grayColor];
    }
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![self.survey.hasFinancialSectorPosition isEqual:@(YES)])
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (![self.survey.hasFinancialSectorPosition isEqual:@(YES)])
    {
        return self.questionOne;
    }
    else
    {
        NSArray *bothQuestions = [NSArray arrayWithObjects:self.questionOne, self.questionTwo, nil];
        return [bothQuestions objectAtIndex:section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == firstSection)
    {
        return self.answerOptionsHasFinancialSectorPosition.count;
    }
    else if (section == secondSection)
    {
        return self.answerOptionsFinancialSectorPosition.count;
    }
    else
    {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section)
    {
        case firstSection:
        {
            self.survey.hasFinancialSectorPosition = indexPath.row == yesCell ? @(NO) : @(YES);
            break;
        }
        case secondSection :
        {
            self.survey.financialSectorPosition = (FinancialSectorPosition)indexPath.row;
            break;
        }
    }
    [tableView reloadData];
}

@end
