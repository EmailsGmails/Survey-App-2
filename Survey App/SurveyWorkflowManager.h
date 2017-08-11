//
//  SurveyWorkflowManager.h
//  SurveyApp
//
//  Created by Emils on 26.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyProgress.h"

@interface SurveyWorkflowManager : NSObject

typedef enum SurveySteps {
    SurveyStep_Intro = 0,
    SurveyStep_ProfessionalClientStatus,
    SurveyStep_ProfessionalClientDescription,
    SurveyStep_OperationPurpose,
    SurveyStep_FinancialActivity,
    SurveyStep_PortfolioCost,
    SurveyStep_FinancialSectorPosition,
    SurveyStep_Verification
} SurveySteps;

+ (NSArray *) stepsForSurvey:(SurveyProgress*)survey;
+ (NSString *)getStepCountFromSurvey:(SurveyProgress *)survey forStep:(SurveySteps)currentStep;
+ (void)clearSurvey:(SurveyProgress *)survey;

@end

@interface UIViewController (SurveyWorkflowManager)

- (void)nextStepForSurvey:(SurveyProgress *)survey currentStep:(SurveySteps)currentStep;

@end
