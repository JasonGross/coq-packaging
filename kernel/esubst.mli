(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: esubst.mli,v 1.3.2.2 2005/01/21 17:14:10 herbelin Exp $ i*)

(*s Compact representation of explicit relocations. \\
   [ELSHFT(l,n)] == lift of [n], then apply [lift l].
   [ELLFT(n,l)] == apply [l] to de Bruijn > [n] i.e under n binders. *)
type lift =
  | ELID
  | ELSHFT of lift * int
  | ELLFT of int * lift

val el_shft : int -> lift -> lift
val el_liftn : int -> lift -> lift
val el_lift : lift -> lift
val reloc_rel : int -> lift -> int
val is_lift_id : lift -> bool

(*s Explicit substitutions of type ['a]. [ESID n] = %n~END = bounded identity. 
  [CONS(t,S)] = $S.t$ i.e. parallel substitution. [SHIFT(n,S)] = 
  $(\uparrow n~o~S)$ i.e. terms in S are relocated with n vars. 
  [LIFT(n,S)] = $(\%n~S)$ stands for $((\uparrow n~o~S).n...1)$. *)
type 'a subs =
  | ESID of int
  | CONS of 'a * 'a subs
  | SHIFT of int * 'a subs
  | LIFT of int * 'a subs

val subs_cons: 'a * 'a subs -> 'a subs
val subs_shft: int * 'a subs -> 'a subs
val subs_lift: 'a subs -> 'a subs
val subs_liftn: int -> 'a subs -> 'a subs
val subs_shift_cons: int * 'a subs * 'a -> 'a subs
val expand_rel: int -> 'a subs -> (int * 'a, int * int option) Util.union
val is_subs_id: 'a subs -> bool
val comp : ('a subs * 'a -> 'a) -> 'a subs -> 'a subs -> 'a subs