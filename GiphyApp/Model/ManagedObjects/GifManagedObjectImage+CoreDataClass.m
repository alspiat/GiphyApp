//
//  GifManagedObjectImage+CoreDataClass.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectImage+CoreDataClass.h"
#import "GiphyApp-Swift.h"

NSString * const imageEntityName = @"GifManagedObjectImage";

@implementation GifManagedObjectImage

+ (NSFetchRequest<GifManagedObjectImage *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:imageEntityName];
}

@dynamic height;
@dynamic url;
@dynamic width;

- (GifManagedObjectImage*)initWithImage:(GifImage *)image context:(NSManagedObjectContext *)context {
    GifManagedObjectImage *gifImage = [NSEntityDescription insertNewObjectForEntityForName:imageEntityName inManagedObjectContext:context];
    
    //set
    gifImage.url = image.url;
    gifImage.height = image.height;
    gifImage.width = image.width;
    return gifImage;
}

@end
