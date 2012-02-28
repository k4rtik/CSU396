/* Examples for testing */

true;
if true then false else true;
if (if true then false else true) then 4 else 564;

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

if (iszero 1) then pred (succ (pred (succ 0))) else false;

if (if true then false else true) then pred (succ (pred (succ 0))) else false;

if (if (iszero 1) then pred (succ (pred (succ 0))) else false) then false else true;

/*succ true;*/
/*pred false;*/
