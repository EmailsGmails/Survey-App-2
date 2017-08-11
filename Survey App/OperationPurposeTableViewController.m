//
//  OperationPurposeTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "OperationPurposeTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface OperationPurposeTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSArray *answerOptions;
@property (strong, nonatomic) NSString *question;

@end

@implementation OperationPurposeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = @[
                           NSLocalizedString(@"OperationPurposeCapitalIncrement", nil),
                           NSLocalizedString(@"OperationPurposeStorage", nil),
                           NSLocalizedString(@"OperationPurposeSpeculativeOperations", nil),
                           NSLocalizedString(@"OperationPurposeThirdPersonService", nil),
                           NSLocalizedString(@"OperationPurposeFinancialMarketOperations", nil),
                           NSLocalizedString(@"OperationPurposeOther", nil)
                           ];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_OperationPurpose];
    self.question = NSLocalizedString(@"OperationPurposeQuestion", nil);
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
    NSLog(@"Chosen options %@", [self.survey.operationPurpose valueForKey:@"description"]);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_OperationPurpose];
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
    cell.checkmark.hidden = ![self.survey.operationPurpose containsObject:@(indexPath.row)];
    self.nextButton.enabled = self.survey.operationPurpose.count > 0 ? YES : NO;
    self.nextButton.backgroundColor = self.survey.operationPurpose.count > 0 ? [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0] : [UIColor grayColor];
    cell.questionLbl.text = self.answerOptions[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.answerOptions.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    QuestionTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkmark.hidden == NO ? [self.survey.operationPurpose removeObjectIdenticalTo:@(indexPath.row)] : [self.survey.operationPurpose addObject:@(indexPath.row)];
    [tableView reloadData];
}

@end
