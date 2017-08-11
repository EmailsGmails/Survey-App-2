//
//  PortfolioCostTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "PortfolioCostTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface PortfolioCostTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSArray *answerOptions;
@property (strong, nonatomic) NSString *question;

@end

@implementation PortfolioCostTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = [NSArray arrayWithObjects:NSLocalizedString(@"PortfolioCostLessThan500ThousandEuros", nil),
                          NSLocalizedString(@"PortfolioCostMoreThan500ThousandEuros", nil), nil];
    self.question = NSLocalizedString(@"PortfolioCostQuestion", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_PortfolioCost];
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
    NSLog(@"Selected choice: %@", self.answerOptions[self.survey.portfolioCost]);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_PortfolioCost];
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
    cell.checkmark.hidden = indexPath.row == self.survey.portfolioCost ? NO : YES;
    self.nextButton.enabled = self.survey.portfolioCost >= 0 ? YES : NO;
    self.nextButton.backgroundColor = self.survey.portfolioCost >= 0 ? [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0] : [UIColor grayColor];
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
    self.survey.portfolioCost = (PortfolioCost)indexPath.row;
    [tableView reloadData];
}

@end
