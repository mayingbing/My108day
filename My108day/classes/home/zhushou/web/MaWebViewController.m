//
//  MaWebViewController.m
//  My108day
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaWebViewController.h"
#import "MBProgressHUD+MJ.h"

@interface MaWebViewController ()<UIWebViewDelegate>
@property(nonatomic ,strong)NSString *webString;
@end

@implementation MaWebViewController


+(instancetype)initWebWithNSString:(NSString *)webString{
    
    MaWebViewController *webView = [[MaWebViewController alloc]init];
    
    webView.webString = webString;
    
    return webView;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview: web];
    
    NSString *urlStr = self.webString;
    
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    web.delegate = self;

}
#pragma mark -UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [MBProgressHUD hideHUD];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [MBProgressHUD hideHUD];
}
@end
