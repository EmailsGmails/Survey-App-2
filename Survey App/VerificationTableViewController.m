//
//  VerificationTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "VerificationTableViewController.h"
#import "VerificationTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface VerificationTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) NSString *answerNo;
@property (strong, nonatomic) NSString *answerYes;
@property (strong, nonatomic) NSArray *answerOptionsClientDescription;
@property (strong, nonatomic) NSArray *answerOptionsOperationPurpose;
@property (strong, nonatomic) NSArray *answerOptionsPortfolioCost;
@property (strong, nonatomic) NSArray *answerOptionsFinancialSectorPosition;

@property (strong, nonatomic) NSString *questionIsProfClient;
@property (strong, nonatomic) NSString *questionClientDescription;
@property (strong, nonatomic) NSString *questionOperationPurpose;
@property (strong, nonatomic) NSString *questionFinancialActivity;
@property (strong, nonatomic) NSString *questionPortfolioCost;
@property (strong, nonatomic) NSString *questionHasFinancialSectorPosition;
@property (strong, nonatomic) NSString *questionFinancialSectorPosition;

@property (strong, nonatomic) NSString *headerString;
@property (strong, nonatomic) NSString *verificationCellIdentifier;

@property (strong, nonatomic) NSArray *allCells;

@end

@implementation VerificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self localizeData];
    self.verificationCellIdentifier = @"VerificationCell";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    self.allCells = [self answersForSurvey:self.survey];
}

- (void) localizeData
{
    self.title = NSLocalizedString(@"Title", nil);
    self.headerString = NSLocalizedString(@"Verification", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromSurvey:self.survey forStep:SurveyStep_Verification];
    self.finishBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    [self.finishBtn setTitle:NSLocalizedString(@"Finish", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    self.answerNo = NSLocalizedString(@"No", nil);
    self.answerYes = NSLocalizedString(@"Yes", nil);
    self.answerOptionsClientDescription = @[
                                            NSLocalizedString(@"ProfessionalClientDescriptionLicensed", nil),
                                            NSLocalizedString(@"ProfessionalClientDescriptionCommercialCommunity", nil),
                                            NSLocalizedString(@"ProfessionalClientDescriptionInvestmentCommercialCommunity", nil),
                                            NSLocalizedString(@"ProfessionalClientDescriptionOther", nil)
                                        ];
    self.answerOptionsOperationPurpose = @[
                                           NSLocalizedString(@"OperationPurposeCapitalIncrement", nil),
                                           NSLocalizedString(@"OperationPurposeStorage", nil),
                                           NSLocalizedString(@"OperationPurposeSpeculativeOperations", nil),
                                           NSLocalizedString(@"OperationPurposeThirdPersonService", nil),
                                           NSLocalizedString(@"OperationPurposeFinancialMarketOperations", nil),
                                           NSLocalizedString(@"OperationPurposeOther", nil)
                                        ];
    self.answerOptionsPortfolioCost = @[
                                       NSLocalizedString(@"PortfolioCostLessThan500ThousandEuros", nil),
                                       NSLocalizedString(@"PortfolioCostMoreThan500ThousandEuros", nil)
                                    ];
    self.answerOptionsFinancialSectorPosition = @[
                                                  NSLocalizedString(@"FinancialSectorPositionAnalyst", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionBroker", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionPortfolioManager", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionInvestmentConsultant", nil),
                                                  NSLocalizedString(@"FinancialSectorPositionRegulationExpert", nil)
                                            ];
    
    self.questionIsProfClient = NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
    self.questionClientDescription = NSLocalizedString(@"ClientDescriptionQuestion", nil);
    self.questionOperationPurpose = NSLocalizedString(@"OperationPurposeQuestion", nil);
    self.questionFinancialActivity = NSLocalizedString(@"FinancialActivityQuestion", nil);
    self.questionPortfolioCost = NSLocalizedString(@"PortfolioCostQuestion", nil);
    self.questionHasFinancialSectorPosition = NSLocalizedString(@"HasFinancialSectorPositionQuestion", nil);
    self.questionFinancialSectorPosition = NSLocalizedString(@"FinancialSectorPositionQuestion", nil);
}

- (IBAction)cancelSurveyButton:(id)sender
{
    [SurveyWorkflowManager clearSurvey:self.survey];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray *) answersForSurvey:(SurveyProgress *)survey
{
    NSMutableArray *steps = [NSMutableArray new];
    [steps addObject:[self isProfClientCell]];
    if ([survey.isProfessionalClient  isEqual: @(YES)]) {
        [steps addObject:[self clientDescriptionCell]];
    }
    [steps addObject:[self operationPurposeCell]];
    [steps addObject:[self financialActivityCell]];
    if ([survey.hasFinancialExperience  isEqual: @(YES)]) {
        [steps addObject:[self portfolioCostCell]];
    }
    [steps addObject:[self hasFinancialSectorPositionCell]];
    if ([survey.hasFinancialSectorPosition  isEqual: @(YES)]) {
        [steps addObject:[self financialSectorPositionCell]];
    }
    return steps;
}

- (UITableViewCell *) isProfClientCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionIsProfClient;
    cell.answerLabel.text = [self.survey.isProfessionalClient isEqual:@(YES)] ? self.answerYes : self.answerNo;
    return cell;
}

- (UITableViewCell *) clientDescriptionCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionClientDescription;
    cell.answerLabel.text = self.answerOptionsClientDescription[self.survey.clientDescription];
    return cell;
}

- (UITableViewCell *) operationPurposeCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    NSMutableArray *multipleAnswers = [NSMutableArray new];
    self.survey.operationPurpose = [[self.survey.operationPurpose sortedArrayUsingSelector: @selector(compare:)] mutableCopy];
    for (int i = 0; i < [self.survey.operationPurpose count]; i++) {
        NSInteger selectedChoice = [self.survey.operationPurpose[i] integerValue];
        [multipleAnswers addObject:self.answerOptionsOperationPurpose[selectedChoice]];
    }
    NSString *parsedAnswers = [multipleAnswers componentsJoinedByString: @"\n"];
    cell.questionLabel.text = self.questionOperationPurpose;
    cell.answerLabel.text = parsedAnswers;
    return cell;
}

- (UITableViewCell *) financialActivityCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionFinancialActivity;
    cell.answerLabel.text = [self.survey.hasFinancialExperience isEqual:@(YES)] ? self.answerYes : self.answerNo;
    return cell;
}

- (UITableViewCell *) portfolioCostCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionPortfolioCost;
    cell.answerLabel.text = self.answerOptionsPortfolioCost[self.survey.portfolioCost];
    return cell;
}

- (UITableViewCell *) hasFinancialSectorPositionCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionHasFinancialSectorPosition;
    cell.answerLabel.text = [self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? self.answerYes : self.answerNo;
    return cell;
}

- (UITableViewCell *) financialSectorPositionCell
{
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:self.verificationCellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.verificationCellIdentifier];
    }
    cell.questionLabel.text = self.questionFinancialSectorPosition;
    cell.answerLabel.text = self.answerOptionsFinancialSectorPosition[self.survey.financialSectorPosition];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headerString;
}

- (IBAction)finishButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = self.allCells[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allCells count];
}

@end
