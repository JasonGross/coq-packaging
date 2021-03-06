(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2014     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(** Basic specifications : sets that may contain logical information *)

Set Implicit Arguments.

Require Import Notations.
Require Import Datatypes.
Require Import Logic.

(** Subsets and Sigma-types *)

(** [(sig A P)], or more suggestively [{x:A | P x}], denotes the subset
    of elements of the type [A] which satisfy the predicate [P].
    Similarly [(sig2 A P Q)], or [{x:A | P x & Q x}], denotes the subset
    of elements of the type [A] which satisfy both [P] and [Q]. *)

Inductive sig (A:Type) (P:A -> Prop) : Type :=
    exist : forall x:A, P x -> sig P.

Inductive sig2 (A:Type) (P Q:A -> Prop) : Type :=
    exist2 : forall x:A, P x -> Q x -> sig2 P Q.

(** [(sigT A P)], or more suggestively [{x:A & (P x)}] is a Sigma-type.
    Similarly for [(sigT2 A P Q)], also written [{x:A & (P x) & (Q x)}]. *)

Inductive sigT (A:Type) (P:A -> Type) : Type :=
    existT : forall x:A, P x -> sigT P.

Inductive sigT2 (A:Type) (P Q:A -> Type) : Type :=
    existT2 : forall x:A, P x -> Q x -> sigT2 P Q.

(* Notations *)

Arguments sig (A P)%type.
Arguments sig2 (A P Q)%type.
Arguments sigT (A P)%type.
Arguments sigT2 (A P Q)%type.

Notation "{ x  |  P }" := (sig (fun x => P)) : type_scope.
Notation "{ x  |  P  & Q }" := (sig2 (fun x => P) (fun x => Q)) : type_scope.
Notation "{ x : A  |  P }" := (sig (fun x:A => P)) : type_scope.
Notation "{ x : A  |  P  & Q }" := (sig2 (fun x:A => P) (fun x:A => Q)) :
  type_scope.
Notation "{ x : A  & P }" := (sigT (fun x:A => P)) : type_scope.
Notation "{ x : A  & P  & Q }" := (sigT2 (fun x:A => P) (fun x:A => Q)) :
  type_scope.

Add Printing Let sig.
Add Printing Let sig2.
Add Printing Let sigT.
Add Printing Let sigT2.


(** Projections of [sig]

    An element [y] of a subset [{x:A | (P x)}] is the pair of an [a]
    of type [A] and of a proof [h] that [a] satisfies [P].  Then
    [(proj1_sig y)] is the witness [a] and [(proj2_sig y)] is the
    proof of [(P a)] *)


Section Subset_projections.

  Variable A : Type.
  Variable P : A -> Prop.

  Definition proj1_sig (e:sig P) := match e with
                                    | exist a b => a
                                    end.

  Definition proj2_sig (e:sig P) :=
    match e return P (proj1_sig e) with
    | exist a b => b
    end.

End Subset_projections.


(** Projections of [sigT]

    An element [x] of a sigma-type [{y:A & P y}] is a dependent pair
    made of an [a] of type [A] and an [h] of type [P a].  Then,
    [(projT1 x)] is the first projection and [(projT2 x)] is the
    second projection, the type of which depends on the [projT1]. *)

Section Projections.

  Variable A : Type.
  Variable P : A -> Type.

  Definition projT1 (x:sigT P) : A := match x with
                                      | existT a _ => a
                                      end.
  Definition projT2 (x:sigT P) : P (projT1 x) :=
    match x return P (projT1 x) with
    | existT _ h => h
    end.

End Projections.

(** [sigT] of a predicate is equivalent to [sig] *)

Lemma sig_of_sigT : forall (A:Type) (P:A->Prop), sigT P -> sig P.
Proof. destruct 1 as (x,H); exists x; trivial. Defined.

Lemma sigT_of_sig : forall (A:Type) (P:A->Prop), sig P -> sigT P.
Proof. destruct 1 as (x,H); exists x; trivial. Defined.

Coercion sigT_of_sig : sig >-> sigT.
Coercion sig_of_sigT : sigT >-> sig.

(** [sumbool] is a boolean type equipped with the justification of
    their value *)

Inductive sumbool (A B:Prop) : Set :=
  | left : A -> {A} + {B}
  | right : B -> {A} + {B}
 where "{ A } + { B }" := (sumbool A B) : type_scope.

Add Printing If sumbool.

Arguments left {A B} _, [A] B _.
Arguments right {A B} _ , A [B] _.

(** [sumor] is an option type equipped with the justification of why
    it may not be a regular value *)

Inductive sumor (A:Type) (B:Prop) : Type :=
  | inleft : A -> A + {B}
  | inright : B -> A + {B}
 where "A + { B }" := (sumor A B) : type_scope.

Add Printing If sumor.

Arguments inleft {A B} _ , [A] B _.
Arguments inright {A B} _ , A [B] _.

(** Various forms of the axiom of choice for specifications *)

Section Choice_lemmas.

  Variables S S' : Set.
  Variable R : S -> S' -> Prop.
  Variable R' : S -> S' -> Set.
  Variables R1 R2 : S -> Prop.

  Lemma Choice :
   (forall x:S, {y:S' | R x y}) -> {f:S -> S' | forall z:S, R z (f z)}.
  Proof.
   intro H.
   exists (fun z => proj1_sig (H z)).
   intro z; destruct (H z); assumption.
  Defined.

  Lemma Choice2 :
   (forall x:S, {y:S' & R' x y}) -> {f:S -> S' & forall z:S, R' z (f z)}.
  Proof.
    intro H.
    exists (fun z => projT1 (H z)).
    intro z; destruct (H z); assumption.
  Defined.

  Lemma bool_choice :
   (forall x:S, {R1 x} + {R2 x}) ->
     {f:S -> bool | forall x:S, f x = true /\ R1 x \/ f x = false /\ R2 x}.
  Proof.
    intro H.
    exists (fun z:S => if H z then true else false).
    intro z; destruct (H z); auto.
  Defined.

End Choice_lemmas.

Section Dependent_choice_lemmas.

  Variables X : Set.
  Variable R : X -> X -> Prop.

  Lemma dependent_choice :
    (forall x:X, {y | R x y}) ->
    forall x0, {f : nat -> X | f O = x0 /\ forall n, R (f n) (f (S n))}.
  Proof.
    intros H x0.
    set (f:=fix f n := match n with O => x0 | S n' => proj1_sig (H (f n')) end).
    exists f.
    split. reflexivity.
    induction n; simpl; apply proj2_sig.
  Defined.

End Dependent_choice_lemmas.


 (** A result of type [(Exc A)] is either a normal value of type [A] or
     an [error] :

     [Inductive Exc [A:Type] : Type := value : A->(Exc A) | error : (Exc A)].

     It is implemented using the option type. *)

Definition Exc := option.
Definition value := Some.
Definition error := @None.

Arguments error [A].

Definition except := False_rec. (* for compatibility with previous versions *)

Arguments except [P] _.

Theorem absurd_set : forall (A:Prop) (C:Set), A -> ~ A -> C.
Proof.
  intros A C h1 h2.
  apply False_rec.
  apply (h2 h1).
Defined.

Hint Resolve left right inleft inright: core v62.
Hint Resolve exist exist2 existT existT2: core.

(* Compatibility *)

Notation sigS := sigT (compat "8.2").
Notation existS := existT (compat "8.2").
Notation sigS_rect := sigT_rect (compat "8.2").
Notation sigS_rec := sigT_rec (compat "8.2").
Notation sigS_ind := sigT_ind (compat "8.2").
Notation projS1 := projT1 (compat "8.2").
Notation projS2 := projT2 (compat "8.2").

Notation sigS2 := sigT2 (compat "8.2").
Notation existS2 := existT2 (compat "8.2").
Notation sigS2_rect := sigT2_rect (compat "8.2").
Notation sigS2_rec := sigT2_rec (compat "8.2").
Notation sigS2_ind := sigT2_ind (compat "8.2").
