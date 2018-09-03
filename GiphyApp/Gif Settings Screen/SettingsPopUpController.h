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

@property (readonly, weak, nonatomic) IBOutlet UIButton *saveAndCancelButton;
@property (readonly, nonatomic, strong) SettingsViewModel *viewModel;

- (instancetype)initWithViewModel:(SettingsViewModel *)viewModel;

@end
