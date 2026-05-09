
/*
 * Copyright (c) 2026 David Stes.
 *
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
 *
 * $Id: gtsexpr.m,v 1.1 2026/05/09 17:31:11 stes Exp $
 */

#include "config.h"
#include <stdlib.h>
#include <assert.h>
#ifndef __OBJECT_INCLUDED__
#define __OBJECT_INCLUDED__
#include <stdio.h> /* FILE */
#include "Object.h" /* Stepstone Object.h assumes #import */
#endif
#include <ordcltn.h>
#include <idarray.h>
#include "node.h"
#include "expr.h"
#include "type.h"
#include "gtsexpr.h"
#include "util.h"
#include "options.h"

@implementation GenericTypeSelectionExpr

- keyw:aRcvr
{
  keyw = aRcvr;
  return self;
}

- expr:aRcvr
{
  expr = aRcvr;
  return self;
}

- assoclist:args
{
  assoclist = args;
  return self;
}

- (int)lineno
{
  return [expr lineno];
}

- filename
{
  return [expr filename];
}

/* non ANSI-C construct such as _Generic(42, int: "integer", default: "unknown")
 * used in glibc_const_generic in sys/cdefs.h 
 * openSUSE Tumbleweed 20260505 glibc 2.43 gcc 15.2.1 <string.h> strstr()
 */

- gen
{
  [keyw gen]; /* gs("_Generic("); */
  gc('(');
  [expr gen];
  gc(',');
  if (assoclist)
    gcommalist(assoclist);
  gc(')');
  return self;
}

- synth
{
  [expr synth];
  [assoclist elementsPerform:_cmd];
  return self;
}

@end
 
