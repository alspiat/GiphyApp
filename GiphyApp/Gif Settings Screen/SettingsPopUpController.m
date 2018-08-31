//
//  SettingsPopUpController.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 30/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "SettingsPopUpController.h"
#import "SettingsPopUpController+PickerView.h"
#import "GiphyApp-Swift.h"

@interface SettingsPopUpController()

@property (nonatomic, strong) SettingsViewModel *viewModel;

@end

static NSString * const kSettingsRatingPicker     = @"rating";
static NSString * const kSettingsClearCacheSwitch = @"clearCache";

/******** RatingType ********
typedef enum {
    RatingTypeY,
    RatingTypeG,
    RatingTypePG,
    RatingTypePG13,
    RatingTypeR,
    RatingTypeNotSafeForWork,
    RatingTypeUnrated
} RatingType;
*/



@implementation SettingsPopUpController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerItems =
    [NSMutableArray arrayWithObjects: @"y",@"g",@"pg",@"pg-13",@"r",@"nsfw",@"unrated", nil];
    //pickerView
    self.ratingPicker.delegate = self;
    self.ratingPicker.dataSource = self;
    //load settings
    [self loadSettings];
    
    //draw views
    [self setupViews];
}


-(void)setupViews {
    //popupView
    self.popUpView.layer.cornerRadius = 30;
    self.popUpView.layer.borderWidth = 1;
    self.popUpView.layer.borderColor = UIColor.darkGrayColor.CGColor;
    
    //cancel button
     [self.saveAndCancelButton setTitleColor:UIColor.giphyPurple forState:UIControlStateNormal];
    self.saveAndCancelButton.layer.cornerRadius = 15;
    self.saveAndCancelButton.layer.borderWidth = 1;
    self.saveAndCancelButton.layer.borderColor = UIColor.darkGrayColor.CGColor;
    
    //clear cache button
    self.clearCacheButton.backgroundColor = UIColor.giphyPurple;
    [self.clearCacheButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    //title label
    self.settingsLabel.layer.borderColor = UIColor.darkGrayColor.CGColor;
    self.settingsLabel.layer.borderWidth = 1;
    
    //pickerView
    self.ratingPicker.layer.borderColor = UIColor.darkGrayColor.CGColor;
    self.ratingPicker.layer.borderWidth = 1;
    
    //swipe
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
    
}

/******* enum Converter **********
-(NSString*)ratingFromType:(RatingType)ratingType {
    switch (RatingTypeY) {
        case RatingTypeY:
            return @"y";
            break;
        case RatingTypeG:
            return @"g";
            break;
        case RatingTypePG:
            return @"pg";
            break;
        case RatingTypePG13:
            return @"pg-13";
            break;
        case RatingTypeR:
            return @"r";
            break;
        case RatingTypeNotSafeForWork:
            return @"nsfw";
            break;
        case RatingTypeUnrated:
            return @"unrated";
            break;
        default:
            return @"unrated";
            break;
    }
}
*/


//MARK: - Actions
- (IBAction)cancelActionHandler:(id)sender {
    [self updateViewModel];
    [self dismissViewControllerAnimated:YES completion:^{
        //dismissed
    }];
}


- (IBAction)clearCacheAction:(id)sender {
    [self updateViewModel];
    //cache clearing
    AppFileManager *fileManger = [[AppFileManager alloc] init];
    
    if ([fileManger clearPreviewsCacheFrom:@""]) {
        NSLog(@"clear cache value changed");
    }
}


-(void)swipeDown:(UISwipeGestureRecognizer*)gesture {
    [self updateViewModel];
    [self dismissViewControllerAnimated:YES completion:nil];
}



//MARK: - Update ViewModel;
-(void)updateViewModel {
     [self saveSettings];
}



//MARK: Save and Load settings
-(void)saveSettings{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.currentRating forKey:kSettingsRatingPicker];
    [userDefaults synchronize];
}

-(void)loadSettings {
     NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger numberOfRow = [userDefaults integerForKey:kSettingsRatingPicker];
    self.currentRating = numberOfRow;
    [self.ratingPicker selectRow:numberOfRow inComponent:0 animated:YES];
    
}




@end
