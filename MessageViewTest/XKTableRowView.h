//
//  XKTableRowView.h
//  MessageViewTest
//
//  Created by Matt Mower on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface XKTableRowView : NSTableRowView {
  NSTrackingArea *_trackingArea;
  BOOL _mouseInside;
}

@end
