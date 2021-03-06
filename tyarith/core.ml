open Format
open Syntax
open Support.Error
open Support.Pervasive

(* ------------------------   EVALUATION  ------------------------ *)

exception NoRuleApplies

let rec ispos t = match t with
    TmSucc(_,TmZero(_)) -> true
  | TmSucc(_,t1) -> ispos t1
  | _ -> false
  
let rec isneg t = match t with
    TmPred(_,TmZero(_)) -> true
  | TmPred(_,t1) -> isneg t1  
  | _ -> false  

let rec isnumericval t = match t with
    TmZero(_) -> true
  | t when ispos t -> true
  | t when isneg t -> true
  | _ -> false

let rec isval t = match t with
    TmTrue(_)  -> true
  | TmFalse(_) -> true
  | t when isnumericval t  -> true
  | _ -> false

let rec eval1 t = match t with
    TmIf(_,TmTrue(_),t2,t3) ->
      t2
  | TmIf(_,TmFalse(_),t2,t3) ->
      t3
  | TmIf(fi,t1,t2,t3) ->
      let t1' = eval1 t1 in
      TmIf(fi, t1', t2, t3)
  | TmSucc(_,TmPred(_,nv1)) when (isnumericval nv1) ->
      nv1
  | TmPred(_,TmSucc(_,nv1)) when (isnumericval nv1) ->
      nv1
  | TmSucc(fi,t1) ->
      let t1' = eval1 t1 in
      TmSucc(fi, t1')
  | TmPred(fi,t1) ->
      let t1' = eval1 t1 in
      TmPred(fi, t1')
  | TmIsZero(_,TmZero(_)) ->
      TmTrue(dummyinfo)
  | TmIsZero(_,nv1) when (ispos nv1 || isneg nv1) ->
      TmFalse(dummyinfo)
  | TmIsZero(fi,t1) ->
      let t1' = eval1 t1 in
      TmIsZero(fi, t1')
  | _ -> 
      raise NoRuleApplies

let rec eval t =
  try let t' = eval1 t
      in eval t'
  with NoRuleApplies -> t

(* ------------------------   TYPING  ------------------------ *)

let rec typeof t =
  match t with
    TmTrue(fi) -> 
      TyBool
  | TmFalse(fi) -> 
      TyBool
  | TmIf(fi,t1,t2,t3) ->
     if (=) (typeof t1) TyBool then
       let tyT2 = typeof t2 in
       if (=) tyT2 (typeof t3) then tyT2
       else TyIf
     else error fi "guard of conditional not a boolean"
  | TmZero(fi) ->
      TyInt
  | TmSucc(fi,t1) ->
      if (=) (typeof t1) TyInt then TyInt
      else error fi "argument of succ is not a number"
  | TmPred(fi,t1) ->
      if (=) (typeof t1) TyInt then TyInt
      else error fi "argument of pred is not a number"
  | TmIsZero(fi,t1) ->
      if (=) (typeof t1) TyInt then TyBool
      else error fi "argument of iszero is not a number"
