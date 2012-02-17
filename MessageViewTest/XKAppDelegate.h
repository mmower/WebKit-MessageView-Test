//
//  XKAppDelegate.h
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XKMessageView;
@class XKInfoPopoverViewController;

@interface XKAppDelegate : NSObject <NSApplicationDelegate> {
  NSMutableDictionary *_rowHeightCache;
  NSArray *_data;
  NSInteger _previousSelectedRow;
  BOOL _tableLock;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet NSPopover *infoPopover;
@property (assign) IBOutlet XKInfoPopoverViewController *infoPopoverViewController;

- (void)tableRowView:(XKMessageView *)view hasDesiredHeight:(CGFloat)height;

- (IBAction)clicked:(id)sender;

@end
