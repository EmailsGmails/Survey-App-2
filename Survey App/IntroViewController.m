
#import "IntroViewController.h"
#import "SurveyWorkflowManager.h"

@interface IntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation IntroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeData];
    if (self.survey == nil)
    {
        self.survey = [SurveyProgress new];
        self.survey.operationPurpose = [NSMutableArray new];
        self.survey.clientDescription = ClientDescription_NIL;
        self.survey.portfolioCost = PortfolioCost_NIL;
        self.survey.financialSectorPosition = FinancialSectorPosition_NIL;
    }
}

- (void) localizeData {
    self.title = NSLocalizedString(@"Title", nil);
    self.descriptionBtn.text = NSLocalizedString(@"SurveyDescription", nil);
    [self.startBtn setTitle:NSLocalizedString(@"StartBtnText", nil) forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backItem.title = NSLocalizedString(@"Title", nil);
}

- (IBAction)Fillinsurvey:(id)sender
{
    NSLog(@"Beginning the survey.");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_Intro];
}

@end
