//
//  ViewController.m
//  JSONDemo
//
//  Created by zhangyan on 16/11/28.
//  Copyright © 2016年 zhangyan. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [tempBtn1 setTitle:@"方式1" forState:UIControlStateNormal];
    tempBtn1.frame = CGRectMake(100, 100, 100, 100);
    tempBtn1.backgroundColor = [UIColor cyanColor];
    [tempBtn1 addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempBtn1];
    
    UIButton *tempBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [tempBtn2 setTitle:@"方式2" forState:UIControlStateNormal];
    tempBtn2.frame = CGRectMake(100, 300, 100, 100);
    tempBtn2.backgroundColor = [UIColor cyanColor];
    [tempBtn2 addTarget:self action:@selector(clickBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempBtn2];
    
    
}

- (void)clickBtn2:(UIButton *)sender{
    
    [self test2];
}

/** 按钮的点击事件 */
- (void)clickBtn1:(UIButton *)sender
{
    [self test1];
    
}

// 方式2，使用AFNetWorking
- (void)test2
{
    
    //传入的参数
    NSDictionary *parameterDic = @{@"username":@"18514531833",@"password":@"asdasd",@"code":@"9999"};
    //你的接口地址
    NSString *url = @"http://sanbox.api.xianjindai.rongba.com:8000/passport/login";

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:error];
        NSString *argString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return argString;
    }];
    
    [manager POST:url parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject ==== %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error ==== %@",error.description);
        
    }];
}




// 方式1
- (void)test1
{
    
    //传入的参数
    NSDictionary *parameterDic = @{@"username":@"18514531833",@"password":@"asdasd",@"code":@"9999"};
    //你的接口地址
    NSString *url=@"http://sanbox.api.xianjindai.rongba.com:8000/passport/login";
    
    
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    
    
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST" URLString:url parameters:parameterDic error:nil];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                   NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   NSDictionary *dicjson = (NSDictionary *)json;
                                   NSLog(@"%@",dicjson);
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       //刷新UI
                                   });
                                   
                               }
                           }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
