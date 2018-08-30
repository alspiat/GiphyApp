//
//  GifManagedObjectImage+CoreDataProperties.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectImage+CoreDataProperties.h"

@implementation GifManagedObjectImage (CoreDataProperties)

+ (NSFetchRequest<GifManagedObjectImage *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"GifManagedObjectImage"];
}

@dynamic webURL;
@dynamic size;
@dynamic height;
@dynamic width;
@dynamic localURL;

@end
