(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: command_windows.mli,v 1.1.2.2 2005/01/21 17:21:33 herbelin Exp $ i*)

class command_window :
  unit ->
  object
    method new_command : ?command:string -> ?term:string -> unit -> unit
    method window : GWindow.window
  end

val main : unit -> unit

val command_window : unit -> command_window


