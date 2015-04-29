//
//  ChildLocation.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCCalloutAnnotationView.h"
#import "KCAnnotation.h"
#import "HttpRequest.h"

@interface ChildLocation : PCBaseVC

@property (weak, nonatomic) IBOutlet UIView *locationInfoView;
@property (weak, nonatomic) IBOutlet UIView *headInfoView;

@end
