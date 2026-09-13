
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
 * $Id: gtsexpr.h,v 1.1 2026/05/09 17:31:11 stes Exp $
 */

@interface GenericTypeSelectionExpr : Expr
{
	id keyw; /* _Generic */
	id expr; /* 42 in  _Generic(42, int: "integer", default: "unknown") */
	id assoclist; /* associations like int: "integer" */
}

- keyw:aKeyw;
- expr:anExpr;
- assoclist:args;
- gen;

@end
 
