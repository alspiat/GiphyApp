//
//  SettingsPopUpController.h
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 30/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewModel;

@interface SettingsPopUpController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveAndCancelButton;
@property (weak, nonatomic) IBOutlet UIPickerView *ratingPicker;
@property (weak, nonatomic) IBOutlet UILabel *chooseRatingLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearCacheButton;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (copy, nonatomic) NSString *currentRating;

@property (readonly, nonatomic, strong) SettingsViewModel *viewModel;

- (instancetype)initWithViewModel:(SettingsViewModel *)viewModel;

@end
