//
//  SettingsPopUpController.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 30/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "SettingsPopUpController.h"

@interface SettingsPopUpController() <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIPickerView *ratingPicker;
@property (weak, nonatomic) IBOutlet UILabel *chooseRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *clearCacheLabel;
@property (weak, nonatomic) IBOutlet UISwitch *clearCacheSwitch;
@property (weak, nonatomic) IBOutlet UIView *popUpView;


@property (strong, nonatomic) NSMutableArray* pickerItems;
@property (assign, nonatomic) NSInteger currentRating;
@end

static NSString * const kSettingsRatingPicker     = @"rating";
static NSString * const kSettingsClearCacheSwitch = @"clearCache";


//typedef enum {
//    RatingTypeY,
//    RatingTypeG,
//    RatingTypePG,
//    RatingTypePG13,
//    RatingTypeR,
//    RatingTypeNotSafeForWork,
//    RatingTypeUnrated
//} RatingType;

@implementation SettingsPopUpController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerItems =
    [NSMutableArray arrayWithObjects: @"y",@"pg",@"pg-13",@"r",@"nsfw",@"unrated", nil];
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
    
    //button
    self.cancelButton.layer.cornerRadius = 15;
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.borderColor = UIColor.darkGrayColor.CGColor;
    
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

//
//-(NSString*)ratingFromType:(RatingType)ratingType {
//    switch (RatingTypeY) {
//        case RatingTypeY:
//            return @"y";
//            break;
//        case RatingTypeG:
//            return @"g";
//            break;
//        case RatingTypePG:
//            return @"pg";
//            break;
//        case RatingTypePG13:
//            return @"pg-13";
//            break;
//        case RatingTypeR:
//            return @"r";
//            break;
//        case RatingTypeNotSafeForWork:
//            return @"nsfw";
//            break;
//        case RatingTypeUnrated:
//            return @"unrated";
//            break;
//        default:
//            return @"unrated";
//            break;
//    }
//}



//MARK: - Actions
- (IBAction)cancelActionHandler:(id)sender {
    [self saveSettings];
    [self dismissViewControllerAnimated:YES completion:^{
        //dismissed
    }];
}

- (IBAction)clearCacheValueChanged:(UISwitch*)sender {
    [self saveSettings];
    NSLog(@"clear cache value changed");
}

-(void)swipeDown:(UISwipeGestureRecognizer*)gesture {
    [self saveSettings];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: Save and Load settings
-(void)saveSettings{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.currentRating forKey:kSettingsRatingPicker];
    [userDefaults setBool:self.clearCacheSwitch.isOn forKey:kSettingsClearCacheSwitch];
    [userDefaults synchronize];
}

-(void)loadSettings {
     NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.clearCacheSwitch.on = [userDefaults boolForKey:kSettingsClearCacheSwitch];
    
    NSInteger numberOfRow = [userDefaults integerForKey:kSettingsRatingPicker];
    self.currentRating = numberOfRow;
    [self.ratingPicker selectRow:numberOfRow inComponent:0 animated:YES];
    
}


//MARK: - PickerViewDelegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerItems.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerItems[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width /4, self.cancelButton.frame.size.height)];
    label.backgroundColor = [UIColor blackColor];
    label.layer.cornerRadius = 15;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    NSString* text = (NSString*)self.pickerItems[row];
    label.text = text.capitalizedString;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentRating = row;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.cancelButton.frame.size.height + 5;
}




@end
