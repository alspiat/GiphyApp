//
//  GifManagedObjectImage+CoreDataClass.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectImage+CoreDataClass.h"
#import "GiphyApp-Swift.h"



@implementation GifManagedObjectImage


- (GifManagedObjectImage*)initWithPreviewImage:(GifEntity *)item context:(NSManagedObjectContext *)context {
    GifManagedObjectImage *gifImage = [NSEntityDescription insertNewObjectForEntityForName:imageEntityName inManagedObjectContext:context];
    
    //set
    gifImage.webURL = item.previewImage.url;
    gifImage.height = item.previewImage.height;
    gifImage.width = item.previewImage.width;
    return gifImage;
}


- (GifManagedObjectImage*)initWithOriginalImage:(GifEntity *)item context:(NSManagedObjectContext *)context {
    GifManagedObjectImage *gifImage = [NSEntityDescription insertNewObjectForEntityForName:imageEntityName inManagedObjectContext:context];
    
    //set
    gifImage.webURL = item.originImage.url;
    gifImage.height = item.originImage.height;
    gifImage.width = item.originImage.width;
    return gifImage;
}

@end
