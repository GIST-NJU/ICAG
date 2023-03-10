/*
 * rollout.h
 *
 * by Gary Wong <gary@cs.arizona.edu>, 1999.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * $Id: rollout.h,v 1.5 2000/11/17 15:44:08 gtw Exp $
 */

#ifndef _ROLLOUT_H_
#define _ROLLOUT_H_

extern int 
Rollout( int anBoard[ 2 ][ 25 ], char *sz, float arOutput[], float arStdDev[],
         int nTruncate, int cGames, int fVarRedn, cubeinfo *pci,
	 evalcontext *pec, int fInvert );

#endif
