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
#import "MaHttpTool.h"

@interface MaOAuthViewController ()<UIWebViewDelegate>

@end

@implementation MaOAuthViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview: web];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2038160851";
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
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"2038160851";
    parameters[@"client_secret"] = @"6e7e90bb1d559bb0e3401bfd21ea732f";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.baidu.com";

    
    MaHttpTool *http = [[MaHttpTool alloc]init];
    
    [http POST:baseUrl parameters:parameters success:^(id responseObject) {
        
        // 请求成功的时候调用
        MaAccount *account = [MaAccount accountWithDict:responseObject];
        
        [MaAccountTool saveAccount:account];
        
        [MaChooseRootViewController chooseRootViewControllerWithWindow:MAKeyWindow];
        
 
    } failure:^(NSError *error) {
        MaOAuthViewController *oauth = [[MaOAuthViewController alloc]init];
        MAKeyWindow.rootViewController = oauth;
        
    }];
 }
@end
