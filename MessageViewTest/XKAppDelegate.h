//
//  XKAppDelegate.h
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XKMessageView;

@interface XKAppDelegate : NSObject <NSApplicationDelegate> {
  NSMutableDictionary *_rowHeightCache;
  NSArray *_data;
  NSInteger _previousSelectedRow;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTableView *tableView;

- (void)tableRowView:(XKMessageView *)view hasDesiredHeight:(NSInteger)height;


@end
