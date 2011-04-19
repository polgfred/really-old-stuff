////////////////////////////////////////////////////////////////////////////////
//
//    checkers_ai.c   ==========================================================
//
//    This file contains the original AI functions for checkers, written in
//    the winter of 94/spring of 95.  It is soon to be significantly improved
//    upon, but this is it in it's classic glory, you might say.
//
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define   BLACK            1
#define   RED              -1
#define   POS(x)           ((1-(x))/2)
#define   EDGE             (color == 1? 7: 0)
#define   MY_CHECKER       (color)
#define   THEIR_CHECKER    (-color)
#define   MY_KING          (2*color)
#define   THEIR_KING       (-2*color)
#define   IS_KING(x,y)     (IMAGE(x,y) == 2 || IMAGE(x,y) == -2)
#define   IS_LEGAL(x,y)    ((x)>=0 && (x)<=7 && (y)>=0 && (y)<=7)
#define   IMAGE(x,y)       (image[(x)+8*(y)])
#define   MY_PIECES        (pieces[POS(color)])
#define   THEIR_PIECES     (pieces[POS(-color)])
#define   IS_MINE(x,y)     (IMAGE(x,y)==MY_CHECKER || IMAGE(x,y)==MY_KING)
#define   IS_THEIRS(x,y)   (IMAGE(x,y)==THEIR_CHECKER || IMAGE(x,y)==THEIR_KING)
#define   INF              16000
#define   NOTYET           -16383

////////////////////////////////////////////////////////////////////////////////
//
//    Prototypes...
//
////////////////////////////////////////////////////////////////////////////////

void  get_next_move(int);
void  best_move(int,int,int,int*);
void  best_jump(int,int,int,int*,int*,int*,char*);
void  move_piece(int,int,int,int,int,int*);
int   value(int,int);

////////////////////////////////////////////////////////////////////////////////
//
//    Globals...
//
////////////////////////////////////////////////////////////////////////////////

extern   int   computer_color;
extern   int   max_depth;
extern   int   pieces[2];
extern   char  move[80];
extern   int   image[64];

////////////////////////////////////////////////////////////////////////////////
//
//    File variables...
//
////////////////////////////////////////////////////////////////////////////////

int   depth = 0;
int   board_eval = NOTYET;
int   score;

////////////////////////////////////////////////////////////////////////////////
//
/* Old values, for reference...

int   piece_value[64] =  { 66, 0, 68, 0, 68, 0, 68, 0,
                           0, 66, 0, 66, 0, 66, 0, 66,
                           68, 0, 68, 0, 68, 0, 68, 0,
                           0, 72, 0, 72, 0, 72, 0, 72,
                           80, 0, 80, 0, 80, 0, 80, 0,
                           0, 96, 0, 96, 0, 96, 0, 96,
                           128, 0, 128, 0, 128, 0, 128, 0,
                           0,  0, 0,  0, 0,  0, 0,  0 };

int   king_value[64] =   { 192, 0, 192, 0, 192, 0, 256, 0,
                           0, 256, 0, 256, 0, 256, 0, 256,
                           192, 0, 384, 0, 384, 0, 256, 0,
                           0, 256, 0, 384, 0, 384, 0, 192,
                           192, 0, 384, 0, 384, 0, 256, 0,
                           0, 256, 0, 384, 0, 384, 0, 192,
                           256, 0, 256, 0, 256, 0, 256, 0,
                           0, 256, 0, 192, 0, 192, 0, 192 };
*/
//
////////////////////////////////////////////////////////////////////////////////


int   piece_value[64] =  { 100, 0, 104, 0, 104, 0, 100, 0,
                           0, 100, 0, 102, 0, 102, 0, 100,
                           102, 0, 105, 0, 105, 0, 102, 0,
                           0, 105, 0, 110, 0, 110, 0, 105,
                           110, 0, 120, 0, 120, 0, 110, 0,
                           0, 120, 0, 130, 0, 130, 0, 120,
                           130, 0, 142, 0, 142, 0, 130, 0,
                           0,   0, 0,   0, 0,   0, 0,   0 };

int   king_value[64] =   { 152, 0, 152, 0, 152, 0, 164, 0,
                           0, 164, 0, 164, 0, 164, 0, 164,
                           152, 0, 180, 0, 180, 0, 164, 0,
                           0, 164, 0, 180, 0, 180, 0, 152,
                           152, 0, 180, 0, 180, 0, 164, 0,
                           0, 164, 0, 180, 0, 180, 0, 152,
                           164, 0, 164, 0, 164, 0, 164, 0,
                           0, 164, 0, 152, 0, 152, 0, 152 };


////////////////////////////////////////////////////////////////////////////////
//
//    get_next_move() ==========================================================
//
//    This function when called, fills in a string containing the best move
//    for 'color', looking max_depth moves into the future.  It is indirectly
//    recursive, meaning it calls best_jump() and best_move() which, in turn,
//    call get_next_move() again, etc.
//
//    Call this program from main() using:
//
//    char  move[80];       // (string to hold computer's move)
//    int   image[64];      // (initialize this first)
//    int   color;          // (color to play)
//
//    get_next_move(color);
//
////////////////////////////////////////////////////////////////////////////////

void  get_next_move(int color)
{
int   i,j,jump_yet=0,i_won=0;
int   tmp_eval=NOTYET,best_so_far;

   best_so_far=board_eval;

   for(i=0;i<=7 && !i_won;++i)
      for(j=0;j<=7 && !i_won;++j)
         if(IS_MINE(i,j))
         {
            best_jump(i,j,color,&jump_yet,&i_won,&tmp_eval,"");

#ifndef NOPRUNE
            if(best_so_far!=NOTYET && tmp_eval!=NOTYET && depth>0 &&
               tmp_eval*(-color)<best_so_far*(-color))
                  goto done1;
#endif /* NOPRUNE */

         }

   if(!i_won && (!jump_yet || tmp_eval==NOTYET))
      for(i=0;i<=7;++i)
         for(j=0;j<=7;++j)
            if(IS_MINE(i,j))
            {
               best_move(i,j,color,&tmp_eval);

#ifndef NOPRUNE
               if(best_so_far!=NOTYET && tmp_eval!=NOTYET && depth>0 &&
                  tmp_eval*(-color)<best_so_far*(-color))
                     goto done1;
#endif /* NOPRUNE */

            }

done1:
   board_eval=tmp_eval;
   if(tmp_eval==NOTYET) board_eval=score;
}


////////////////////////////////////////////////////////////////////////////////
//
//    best_jump() ==============================================================
//
//    This function calculates the best jump, if one is available, from the
//    coordinates x,y, using get_next_move() to plow through through the
//    possibilities.
//
////////////////////////////////////////////////////////////////////////////////

void  best_jump(int x,int y,int color,int *jumpp,int *i_wonp,
                int *tmp_eval,char *passed_move)
{
int   piece,i,j,new_x,new_y,mid_x,mid_y;
int   save_jump,first_jump=0,jump_val,got_it,fix[2];
char  tmp_move[80],this_jump[3];

   srand(1);
   strcpy(tmp_move,passed_move);
   for(i=-2;i<=2;i+=4)
   {
      for(j=-2;j<=2;j+=4)
      {
         piece=IMAGE(x,y);
         new_x=x+i;
         new_y=y+j;
         mid_x=x+(i/2);
         mid_y=y+(j/2);

         if(!*tmp_move)
            sprintf(tmp_move,"%c%c",x+'a',y+'1');
         sprintf(this_jump,"%c%c",new_x+'a',new_y+'1');
         strcat(tmp_move,this_jump);

         if((j==2*color || piece==MY_KING) && IS_LEGAL(new_x,new_y)
            && !IMAGE(new_x,new_y) && !*i_wonp &&(IS_THEIRS(mid_x,mid_y)))
         {
            *fix=0;
            *(fix+1)=0;
            save_jump=*jumpp;

            move_piece(color,x,y,new_x,new_y,fix);

            got_it=!THEIR_PIECES;
            if(!*fix && !got_it) best_jump(new_x,new_y,color,
               jumpp,i_wonp,tmp_eval,tmp_move);
            if(*(fix+1))
            {
               if(!*jumpp)
                  first_jump=1;
               *jumpp=1;
            }
            jump_val=*jumpp;
            if(got_it)
               board_eval=color*INF;
            else if(*jumpp==1 || depth<max_depth)
            {
               ++depth;
               get_next_move(-color);
               --depth;
            }
            else
               board_eval=score;

            if(!save_jump && *jumpp)
               *jumpp=-1;
            else
               *jumpp=save_jump;

            move_piece(color,new_x,new_y,x,y,fix);

            if(!(jump_val==-1) &&
               (got_it || *tmp_eval==NOTYET || first_jump ||
               board_eval*color > *tmp_eval*color ||
               (board_eval==*tmp_eval && rand()%2)))
            {
               *i_wonp=got_it;
               *tmp_eval=board_eval;
               if(depth==0)
                  strcpy(move,tmp_move);
            }
            else
               board_eval=*tmp_eval;

            if(*i_wonp)
               i=j=2;
         }
         tmp_move[strlen(tmp_move)-2]=0x00;
      }
   }
}


////////////////////////////////////////////////////////////////////////////////
//
//    best_move() ==============================================================
//
//    This function calculates the best move,if one is available,from the
//    coordinates x,y, using get_next_move() to plow through through the
//    possibilities.
//
////////////////////////////////////////////////////////////////////////////////

void  best_move(int x,int y,int color,int *tmp_eval)
{
int   piece,i,j,new_x,new_y;
int   fix[2];

   srand(1);
   for(i=-1;i<=1;i+=2)
   {
      for(j=-1;j<=1;j+=2)
      {
         piece=IMAGE(x,y);
         new_x=x+i;
         new_y=y+j;

         if((j==color || piece==MY_KING) && IS_LEGAL(new_x,new_y) &&
            !IMAGE(new_x,new_y) && THEIR_PIECES)
         {
            *fix=0;
            *(fix+1)=0;

            move_piece(color,x,y,new_x,new_y,fix);

            if(depth< max_depth)
            {
               ++depth;
               get_next_move(-color);
               --depth;
            }
            else
               board_eval=score;

            move_piece(color,new_x,new_y,x,y,fix);

            if(*tmp_eval==NOTYET ||
               board_eval*color>*tmp_eval*color ||
               (board_eval==*tmp_eval && rand()%2))
            {
               *tmp_eval=board_eval;
               if(depth==0)
                  sprintf(move,"%c%c%c%c",x+'a',y+'1',new_x+'a',new_y+'1');
            }
            else
               board_eval=*tmp_eval;
         }
      }
   }
}


////////////////////////////////////////////////////////////////////////////////
//
//    move_piece() =============================================================
//
//    This function moves the piece at(x,y) to (new_x,new_y).  The fix array
//    is populated with the value of the jumped piece, if there was one, and
//    1 if the piece was promoted.  It also replaces the piece which was jumped
//    and promotes the piece, if set.
//
////////////////////////////////////////////////////////////////////////////////

void  move_piece(int color,int x,int y,int new_x,int new_y,int *fix)
{
int   piece,promoted,mid_x,mid_y,middle,mid_val;

   piece=IMAGE(x,y);
   promoted=(new_y==EDGE && piece==MY_CHECKER)? 1: 0;
   IMAGE(new_x,new_y)=promoted? 2*piece: piece/(1+*fix);
   score+=color*(value(new_x,new_y)-value(x,y));
   IMAGE(x,y)=0;

   if(new_x-x==2 || new_x-x==-2)
   {
      middle=IMAGE(mid_x=(x+new_x)/2,mid_y=(y+new_y)/2);
      mid_val=value(mid_x,mid_y);

      if(IS_THEIRS(mid_x,mid_y))
      {
         *(fix+1)=middle;
         IMAGE(mid_x,mid_y)=0;
         --pieces[POS(-color)];
         score+=color*mid_val;
      }
      else if(!middle)
      {
         middle=IMAGE(mid_x,mid_y)=*(fix+1);
         mid_val=value(mid_x,mid_y);
         ++pieces[POS(-color)];
         score-=color*mid_val;
         *(fix+1)=0;
      }
   }

   *fix=promoted;
}


////////////////////////////////////////////////////////////////////////////////
//
//    value() ==================================================================
//
//    Returns the heuristic value of the piece at (x,y).
//
////////////////////////////////////////////////////////////////////////////////

int value(int x,int y)
{
int   piece;

   piece=IMAGE(x,y);

   if(piece==1)
      return piece_value[x+8*y];
   else if(piece==-1)
      return piece_value[(7-x)+8*(7-y)];
   else if(piece==2 || piece==-2)
      return king_value[x+8*y];

   return 0;
}
