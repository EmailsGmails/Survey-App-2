//
//  SurveyProgress.h
//  SurveyApp
//
//  Created by Emils on 19.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvestSurveyEnums.h"

@interface SurveyProgress : NSObject

@property (nonatomic, strong) NSObject *isProfessionalClient;
@property (nonatomic, assign) ClientDescription clientDescription;
@property (nonatomic, strong) NSMutableArray *operationPurpose;
@property (nonatomic, assign) NSObject *hasFinancialExperience;
@property (nonatomic, assign) PortfolioCost portfolioCost;
@property (nonatomic, assign) NSObject *hasFinancialSectorPosition;
@property (nonatomic, assign) FinancialSectorPosition financialSectorPosition;

@end
