//
//  SurveyWorkflowManager.m
//  SurveyApp
//
//  Created by Emils on 26.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//
#import "SurveyWorkflowManager.h"

#import "IntroViewController.h"
#import "ProfessionalClientStatusTableViewController.h"
#import "ClientDescriptionTableViewController.h"
#import "OperationPurposeTableViewController.h"
#import "FinancialActivityTableViewController.h"
#import "PortfolioCostTableViewController.h"
#import "FinancialSectorPositionTableViewController.h"
#import "VerificationTableViewController.h"

//----------------------------------------------------

@interface SurveyStepInfo : NSObject

@property (assign, nonatomic) SurveySteps step;
+ (SurveyStepInfo *) step:(SurveySteps)step;

@end

@implementation SurveyStepInfo

+ (SurveyStepInfo *) step:(SurveySteps)step
{
    SurveyStepInfo *s = [SurveyStepInfo new];
    s.step = step;
    return s;
}

@end

//----------------------------------------------------

@implementation SurveyWorkflowManager

+ (NSArray *) stepsForSurvey:(SurveyProgress *)survey {
    NSMutableArray *steps = [NSMutableArray new];
    [steps addObject:[SurveyStepInfo step:SurveyStep_Intro]];
    [steps addObject:[SurveyStepInfo step:SurveyStep_ProfessionalClientStatus]];
    if ([survey.isProfessionalClient  isEqual: @(YES)]) {
        [steps addObject: [SurveyStepInfo step:SurveyStep_ProfessionalClientDescription]];
    }
    [steps addObject:[SurveyStepInfo step:SurveyStep_OperationPurpose]];
    [steps addObject:[SurveyStepInfo step:SurveyStep_FinancialActivity]];
    if ([survey.hasFinancialExperience isEqual: @(YES)]) {
        [steps addObject: [SurveyStepInfo step:SurveyStep_PortfolioCost]];
    }
    [steps addObject:[SurveyStepInfo step:SurveyStep_FinancialSectorPosition]];
    [steps addObject:[SurveyStepInfo step:SurveyStep_Verification]];
    return steps;
}

+ (NSString *)getStepCountFromSurvey:(SurveyProgress *)survey forStep:(SurveySteps)currentStep {
    int step = [SurveyWorkflowManager currentStepNumberForSurvey:survey nextStep:currentStep];
    
    NSString *stepString = [NSString stringWithFormat:NSLocalizedString(@"StepLabel", nil), step, (unsigned long)[self stepsForSurvey:survey].count - 1];
    return stepString;
}

+ (int)currentStepNumberForSurvey:(SurveyProgress *)survey nextStep:(SurveySteps)currentStep {
    NSArray *steps = [SurveyWorkflowManager stepsForSurvey:survey];
    
    for(int i = 0; i < steps.count; i++)
    {
        SurveyStepInfo *step = steps[i];
        if(step.step == currentStep)
        {
            return i;
        }
    }
    
    return 0;
}

+ (void)clearSurvey:(SurveyProgress *)survey {
    survey.isProfessionalClient = nil;
    survey.clientDescription = ClientDescription_NIL;
    survey.operationPurpose = [NSMutableArray new];
    survey.hasFinancialExperience = nil;
    survey.portfolioCost = PortfolioCost_NIL;
    survey.hasFinancialSectorPosition = nil;
    survey.financialSectorPosition = FinancialSectorPosition_NIL;
}

@end

@implementation UIViewController (SurveyWorkflowManager)

- (void)openSurvey:(SurveyProgress *)survey nextStep:(SurveyStepInfo *)step
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    switch (step.step)
    {
        case SurveyStep_Intro:
        {
            IntroViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"Intro"];
            self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"Title", nil);
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_ProfessionalClientStatus:
        {
            ProfessionalClientStatusTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"ProfessionalClientStatus"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_ProfessionalClientDescription:
        {
            ClientDescriptionTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"ClientDescription"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_OperationPurpose:
        {
            OperationPurposeTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"OperationPurpose"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_FinancialActivity:
        {
            FinancialActivityTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"FinancialActivity"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_PortfolioCost:
        {
            PortfolioCostTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"PortfolioCost"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_FinancialSectorPosition:
        {
            FinancialSectorPositionTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"FinancialSectorPosition"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        case SurveyStep_Verification:
        {
            VerificationTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"Verification"];
            uvc.survey = survey;
            [self.navigationController pushViewController:uvc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)nextStepForSurvey:(SurveyProgress *)survey currentStep:(SurveySteps)currentStep {
    NSArray *steps = [SurveyWorkflowManager stepsForSurvey:survey];
    
    for(int i = 0; i < steps.count; i++)
    {
        SurveyStepInfo *step = steps[i];
        if(step.step == currentStep)
        {
            [self openSurvey:survey nextStep:steps[i + 1]];
        }
    }
}

@end
