//
//  ChildLocation.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ChildLocation.h"

@interface ChildLocation ()<MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;

    NSString *_addressInfo;
    NSString *_city;
    
    UIButton *rightBtn;
    
    CGFloat point_X;
    CGFloat point_Y;
    
    double latitude;
    double longitude;
}
@end

//http://www.cnblogs.com/kenshincui/p/4125570.html

@implementation ChildLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"网小明在这里";
    [self setBackButtonVisible:@"首页" andButtonFrame:NAVIGATION_RECT_MIN];
    
    point_X = 39.915352;
    point_Y = 116.397105;
    
    [self initNavRightBtn];
    
    [self initGUI];
    
    [self requestLocationInfo];
}

-(void)initNavRightBtn{
    UIImage *image = [UIImage imageNamed:@"loading"];
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(refreshLocationPoint) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBBItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBBItem];
}

-(void)requestLocationInfo{

    NSString *uid_p = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    [HTTPREQUEST requestWithPost:@"user/children_location_info.php" requestParams:@{uid_p:@"uid"}
                successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"===location==%@",result);
                point_X = [result[@"position_x"] floatValue];
                point_Y = [result[@"position_y"] floatValue];
        }
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

//加载旋转动画
-(UIButton *)rotate360DegreeWithImageView:(UIButton *)btn{
    
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 10;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,btn.frame.size.width, btn.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [btn.imageView.image drawInRect:CGRectMake(1,1,btn.frame.size.width-2,btn.frame.size.height-2)];
    btn.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [btn.layer addAnimation:animation forKey:nil];
    return btn;
}

-(void)refreshLocationPoint{
    // 旋转动画。
    UIBarButtonItem *rightBBItem = [[UIBarButtonItem alloc] initWithCustomView:[self rotate360DegreeWithImageView:rightBtn]];
    [self.navigationItem setRightBarButtonItem:rightBBItem];
    //请求数据
    [self requestLocationInfo];
}

#pragma mark 添加地图控件
-(void)initGUI{
    CGRect rect = [UIScreen mainScreen].bounds;
    _mapView = [[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate = self;
    
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    
    //添加大头针
    [self addAnnotation];
}

#pragma mark 添加大头针
-(void)addAnnotation{
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(point_X, point_Y);
    KCAnnotation *annotation1 = [[KCAnnotation alloc]init];
    annotation1.title = @"CMJ Studio";
    annotation1.subtitle = @"上海市浦东新区祖冲之路2305";
    annotation1.coordinate = location1;
    annotation1.image = [UIImage imageNamed:@"location_box"];
    annotation1.icon = [UIImage imageNamed:@"accout"];
    annotation1.detail = @"CMJ Studio...";
    annotation1.rate = [UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation1];
    
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(point_X, point_Y);
    KCAnnotation *annotation2 = [[KCAnnotation alloc]init];
    annotation2.title = @"Kenshin&Kaoru";
    annotation2.subtitle = @"Kenshin Cui's Home";
    annotation2.coordinate = location2;
    annotation2.image = [UIImage imageNamed:@"location_box"];
    annotation2.icon = [UIImage imageNamed:@"accout"];
    annotation2.detail = @"Kenshin Cui...";
    annotation2.rate = [UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation2];
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1 = @"AnnotationKey1";
        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            //            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset = CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation = annotation;
        annotationView.image = ((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else if([annotation isKindOfClass:[KCCalloutAnnotation class]]){
        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        KCCalloutAnnotationView *calloutView = [KCCalloutAnnotationView calloutViewWithMapView:mapView];
        calloutView.annotation = annotation;
        return calloutView;
    } else {
        return nil;
    }
}

#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    KCAnnotation *annotation = view.annotation;
    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
        //        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        KCCalloutAnnotation *annotation1 = [[KCCalloutAnnotation alloc]init];
        annotation1.icon = annotation.icon;
        annotation1.detail = annotation.detail;
        annotation1.rate = annotation.rate;
        annotation1.coordinate = view.annotation.coordinate;
        [mapView addAnnotation:annotation1];
    }
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}


#pragma mark 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    [self removeCustomAnnotation];
}

#pragma mark 移除所用自定义大头针
-(void)removeCustomAnnotation{
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
            [_mapView removeAnnotation:obj];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
