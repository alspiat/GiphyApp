//
//  SettingsPopUpController+PickerView.m
//  GiphyApp
//
//  Created by Dzmitry Tarelkin on 8/31/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "SettingsPopUpController+PickerView.h"
#import "GiphyApp-Swift.h"

@implementation SettingsPopUpController (PickerView)

//MARK: - PickerViewDelegate and DataSource
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.viewModel.ratingItems.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.viewModel.ratingItems[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width / 2, self.saveAndCancelButton.frame.size.height)];
    label.backgroundColor = [UIColor blackColor];
    label.layer.cornerRadius = 15;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    NSString* text = (NSString*)self.viewModel.ratingItems[row];
    label.text = text.uppercaseString;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentRating = self.viewModel.ratingItems[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.saveAndCancelButton.frame.size.height + 5;
}

@end
