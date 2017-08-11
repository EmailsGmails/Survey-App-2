//
//  InvestSurveyEnums.h
//  SurveyApp
//
//  Created by Emils on 24.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestSurveyEnums : NSObject {
    
}

typedef enum ClientDescription {
    ClientDescription_NIL = -1,
    ClientDescription_Licensed,
    ClientDescription_CommercialCommunity,
    ClientDescription_InvestmentCommercialCommunity,
    ClientDescription_Other
} ClientDescription;

typedef enum OperationPurpose {
    OperationPurpose_NIL = -1,
    OperationPurpose_CapitalIncrement,
    OperationPurpose_Storage,
    OperationPurpose_SpeculativeOperations,
    OperationPurpose_ThirdPersonService,
    OperationPurpose_FinancialMarketOperations,
    OperationPurpose_Other
} OperationPurpose;

typedef enum PortfolioCost {
    PortfolioCost_NIL = -1,
    PortfolioCost_LessThan500ThousandEuros,
    PortfolioCost_MoreThan500ThousandEuros
} PortfolioCost;

typedef enum FinancialSectorPosition {
    FinancialSectorPosition_NIL = -1,
    FinancialSectorPosition_Analyst,
    FinancialSectorPosition_Broker,
    FinancialSectorPosition_PortfolioManager,
    FinancialSectorPosition_InvestmentConsultant,
    FinancialSectorPosition_RegulationExpert
} FinancialSectorPosition;

@end
