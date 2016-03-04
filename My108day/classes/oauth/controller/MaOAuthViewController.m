//
//  MaOAuthViewController.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaOAuthViewController.h"
#import "AFNetworking.h"
#import "MaAccountTool.h"
#import "MaAccount.h"
#import "MaChooseRootViewController.h"

@interface MaOAuthViewController ()<UIWebViewDelegate>

@end

@implementation MaOAuthViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview: web];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"3713969596";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    

    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    web.delegate = self;
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    

    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code{
    
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        NSString *baseUrl = @"https://api.weibo.com/oauth2/access_token";
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"client_id"] = @"3713969596";
        parameters[@"client_secret"] = @"bf30764af6caadc864b79f6521c44859";
        parameters[@"grant_type"] = @"authorization_code";
        parameters[@"code"] = code;
        parameters[@"redirect_uri"] = @"http://www.baidu.com";
    
        [mgr POST:baseUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
            // 请求成功的时候调用
            MaAccount *account = [MaAccount accountWithDict:responseObject];
            
            [MaAccountTool saveAccount:account];
            
            [MaChooseRootViewController chooseRootViewControllerWithWindow:MAKeyWindow];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
