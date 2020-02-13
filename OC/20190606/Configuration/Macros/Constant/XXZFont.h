//
//  XXZFont.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#ifndef XXZFont_h
#define XXZFont_h

/* ***************************************************** */
#define FONT_S(s) [UIFont systemFontOfSize:s]
#define FONT_B(s) [UIFont boldSystemFontOfSize:s]
#define FONT_M(s) [UIFont fontWithName:@"PingFang-SC-Medium" size:s]
#define FONT(s) FONT_S(s)

/* ***************************************************** */
#define font_ultraLight(w)       [UIFont ultraLight:w]
#define font_thin(w)                 [UIFont thin:w]
#define font_light(w)                [UIFont light:w]
#define font_regular(w)            [UIFont regular:w]
#define font_medium(w)           [UIFont medium:w]
#define font_semibold(w)         [UIFont semibold:w]
#define font_bold(w)                 [UIFont bold:w]
#define font_heavy(w)              [UIFont heavy:w]
#define font_black(w)               [UIFont black:w]
#define font_italic(w)               [UIFont italic:w]

/* ***************************************************** */

#endif /* XXZFont_h */
