//
//  SettingsPopUpController.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 30/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "SettingsPopUpController.h"
#import "SettingsPopUpController+PickerView.h"
#import "ButtonConstants.h"
#import "MessageConstants.h"
#import "GiphyApp-Swift.h"

@interface SettingsPopUpController()

@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (readwrite, weak, nonatomic) IBOutlet UIButton *saveAndCancelButton;
@property (weak, nonatomic) IBOutlet UIPickerView *ratingPicker;
@property (weak, nonatomic) IBOutlet UILabel *chooseRatingLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearCacheButton;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (readwrite, nonatomic, strong) SettingsViewModel *viewModel;

@end

@implementation SettingsPopUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //pickerView
    self.ratingPicker.delegate = self;
    self.ratingPicker.dataSource = self;

    //draw views
    [self setupViews];
    
    [self bindToViewModel];
    [self viewModelDidUpdate];
}

- (instancetype)initWithViewModel:(SettingsViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)setupViews {
    //popupView
    self.popUpView.layer.cornerRadius = 15;
    self.popUpView.layer.borderWidth = 1;
    self.popUpView.layer.borderColor = UIColor.darkGrayColor.CGColor;
    
    //cancel button
    self.saveAndCancelButton.layer.cornerRadius = 15;
    self.saveAndCancelButton.layer.borderWidth = 1;
    self.saveAndCancelButton.layer.borderColor = UIColor.darkGrayColor.CGColor;
    
    //title label
    self.settingsLabel.layer.borderColor = UIColor.darkGrayColor.CGColor;
    self.settingsLabel.layer.borderWidth = 1;
    
    //swipe
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}


//MARK: - Actions
- (IBAction)saveActionHandler:(id)sender {
    [self saveSettings];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clearCacheAction:(id)sender {
    AppFileManager *fileManger = [[AppFileManager alloc] init];
    
    if ([fileManger clearPreviewsCache]) {
        [self showInfoAlert:gifClearingTitle message:gifClearingMessage completion:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

//show info Alert
- (void)showInfoAlert:(NSString *)title message:(NSString *)message completion: (void(^)(void))completion {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:gifOkActionTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:completion];
}

- (void)swipeDown:(UISwipeGestureRecognizer*)gesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: Save and Load settings
- (void)saveSettings {
    [self.viewModel saveRatingToUserDefaults];
}

//MARK: - Binding
- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    if ([self.viewModel currentRating]) {
        [self.ratingPicker selectRow:[self.viewModel.ratingItems indexOfObject:[self.viewModel currentRating]] inComponent:0 animated:YES];
    }
}




@end
