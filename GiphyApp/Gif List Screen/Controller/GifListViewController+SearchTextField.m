//
//  GifListViewController+SearchTextField.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/29/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifListViewController+SearchTextField.h"
#import "GiphyApp-Swift.h"

@implementation GifListViewController (SearchTextField)

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [Navigation.shared showSearchingGifsWithQuery:self.searchTextField.text];
    return YES;
}

@end
