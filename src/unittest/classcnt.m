
/*
 * Portable Object Compiler (c) 2025.  All Rights Reserved.
 * $Id: classcnt.m,v 1.1 2025/03/15 14:50:40 stes Exp $
 */

/*
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Library General Public License as published 
 * by the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include "config.h"
#include <assert.h>
#include "classcnt.h"
#if OBJC_BLOCKS
#include "Block.h"
#endif
#include <objpak.h>
#include "node.h"
#include "trlunit.h"
#include "options.h"
#include "util.h"
#include "symbol.h"

@implementation ClassCount

int okblock = 1;
static int numclasses = 0;

static void
p(int tabs,id c)
{
    numclasses++;
    while (tabs--) printf("\t");printf("%s\n",[c name]);
}

static void
phierarchy(id c)
{
    int tabs = 0;
    id b = { :e | p(tabs++,e);[[e subclasses] do:b];tabs--;};
    [b value:c];
}

/*
 * idea here is to link an executable which like objc1
 * is processing TranslationUnit classes
 *
 * the main() program first creates a TranslationUnit instance,
 * just like the objc1 executable
 *
 * however here for testing purposes we just print some info
 * that can then be used as a basic regression test to see that the
 * produced executable (which uses a new runtime) is not simply core dumping
 *
 */

- run
{
   id trlunit = [TranslationUnit new];
   phierarchy(Object);
   printf("Object Unit Test: number of classes is %i\n",numclasses);
   return self;
}

@end

