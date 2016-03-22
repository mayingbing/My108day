//
//  MaStatuesFrame.m
//  My108day
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaStatuesFrame.h"
#import "CZStatus.h"

#define margin 10

@implementation MaStatuesFrame

-(void)setStatues:(CZStatus *)statues{
    
    _statues = statues;
    
    [self setUpAllViewFrame];
}

-(void)setUpAllViewFrame{
    

    [self setUpOriginalViewHeight];
    
    [self setUpRetweetedViewHeight];
    
    [self setUpToolBarViewHeight];
    
    self.cellHeight = self.originalViewHeight + self.retweetedViewHeight + self.toolBarViewHeight;
}

-(void)setUpOriginalViewHeight{
    
    
    self.originalViewHeight = margin + 35 +10;
    
    if (self.statues.text.length) {
        
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.statues.text];
        NSRange range = NSMakeRange(0, self.statues.text.length);
        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-2*margin, MAXFLOAT);
        self.originalViewHeight += [self.statues.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        self.originalViewHeight +=10;
    }
    
    if (self.statues.pic_urls.count) {
        
        //列数
        
        
        int col = self.statues.pic_urls.count == 4 ? 2 :3 ;
        
        // 获取总行数 = (总个数 - 1) / 总列数 + 1
        int row = (self.statues.pic_urls.count - 1) / col + 1;
        
        self.originalViewHeight += 70*row + margin*row;
    }
}

-(void)setUpRetweetedViewHeight{
    self.retweetedViewHeight = 0;
    if (self.statues.retweeted_status.text.length) {
        
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.statues.retweeted_status.text];
        NSRange range = NSMakeRange(0, self.statues.retweeted_status.text.length);
        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-2*margin, MAXFLOAT);
        self.retweetedViewHeight += [self.statues.retweeted_status.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        self.retweetedViewHeight +=10;
    }
    
    if (self.statues.retweeted_status.pic_urls.count) {
        
        //列数
        
        int col = self.statues.retweeted_status.pic_urls.count == 4 ? 2 :3 ;
        
        // 获取总行数 = (总个数 - 1) / 总列数 + 1
        int row = (int)(self.statues.retweeted_status.pic_urls.count - 1) /(int)col + 1;
        
        self.retweetedViewHeight += 70*row + margin*row;
    }

    
}

-(void)setUpToolBarViewHeight{
    
    self.toolBarViewHeight = 44 +margin;
    
}
@end
