/* Examples for testing */

true;
if true then false else true;

succ 5;
/* pred -2; */
0; 

succ (pred 0);
succ (succ 0);
succ (succ (pred 0));
pred 0;
pred (pred 0);
pred (succ (succ 0));

iszero (pred 0);
iszero (succ 0);
iszero (pred (succ 0));
iszero (succ (pred 0));
iszero (succ (succ (pred 0)));
iszero (succ (succ (pred (pred 0))));

/*succ true;*/
/*pred false;*/

/*if (iszero 0) then pred (succ (pred (succ 0))) else false;*/
