/*
 * ArcPro MMORPG Server
 * Copyright (c) 2011-2013 ArcPro Speculation <http://arcpro.sexyi.am/>
 * Copyright (c) 1994-2013 Lua <http://www.lua.org>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef llex_h
#define llex_h

#include "lobject.h"
#include "lzio.h"


#define FIRST_RESERVED	257

/* maximum length of a reserved word */
#define TOKEN_LEN	(sizeof("function")/sizeof(char))


/*
* WARNING: if you change the order of this enumeration,
* grep "ORDER RESERVED"
*/
enum RESERVED
{
    /* terminal symbols denoted by reserved words */
    TK_AND = FIRST_RESERVED, TK_BREAK,
    TK_DO, TK_ELSE, TK_ELSEIF, TK_END, TK_FALSE, TK_FOR, TK_FUNCTION,
    TK_IF, TK_IN, TK_LOCAL, TK_NIL, TK_NOT, TK_OR, TK_REPEAT,
    TK_RETURN, TK_THEN, TK_TRUE, TK_UNTIL, TK_WHILE,
    /* other terminal symbols */
    TK_CONCAT, TK_DOTS, TK_EQ, TK_GE, TK_LE, TK_NE, TK_NUMBER,
    TK_NAME, TK_STRING, TK_EOS
};

/* number of reserved words */
#define NUM_RESERVED	(cast(int, TK_WHILE-FIRST_RESERVED+1))


/* array with token `names' */
LUAI_DATA const char* const luaX_tokens [];


typedef union
{
	lua_Number r;
	TString* ts;
} SemInfo;  /* semantics information */


typedef struct Token
{
	int token;
	SemInfo seminfo;
} Token;


typedef struct LexState
{
	int current;  /* current character (charint) */
	int linenumber;  /* input line counter */
	int lastline;  /* line of last token `consumed' */
	Token t;  /* current token */
	Token lookahead;  /* look ahead token */
	struct FuncState* fs;  /* `FuncState' is private to the parser */
	struct lua_State* L;
	ZIO* z;  /* input stream */
	Mbuffer* buff;  /* buffer for tokens */
	TString* source;  /* current source name */
	char decpoint;  /* locale decimal point */
} LexState;


LUAI_FUNC void luaX_init(lua_State* L);
LUAI_FUNC void luaX_setinput(lua_State* L, LexState* ls, ZIO* z,
                             TString* source);
LUAI_FUNC TString* luaX_newstring(LexState* ls, const char* str, size_t l);
LUAI_FUNC void luaX_next(LexState* ls);
LUAI_FUNC void luaX_lookahead(LexState* ls);
LUAI_FUNC void luaX_lexerror(LexState* ls, const char* msg, int token);
LUAI_FUNC void luaX_syntaxerror(LexState* ls, const char* s);
LUAI_FUNC const char* luaX_token2str(LexState* ls, int token);


#endif