(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* Certification of Imperative Programs / Jean-Christophe Filli�tre *)

(* $Id: pdb.mli,v 1.2.16.1 2004/07/16 19:30:01 herbelin Exp $ *)

open Ptype
open Past


(* Here we separate local and global variables, we check the use of
 * references and arrays w.r.t the local and global environments, etc.
 * These functions directly raise UserError exceptions on bad programs.
 *)

val check_type_v : Names.identifier list -> 'a ml_type_v -> unit

val db_prog : program -> program

