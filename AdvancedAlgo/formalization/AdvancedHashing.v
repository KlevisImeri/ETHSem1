(* Lecture 6: Advanced Hashing *)

From Stdlib Require Import Reals Unicode.Utf8.
From mathcomp Require Import all_boot ssralg order ssrnum reals Rstruct.
From infotheo Require Import fdist proba.

Set Printing Notations.
Unset Printing Implicit.
Unset Printing Coercions.

Import GRing.Theory ssrnum.Num.Theory.

Local Open Scope ring_scope.
Local Open Scope proba_scope.

Notation "[ n ]" := 'I_n
  (at level 0, n at level 99) : type_scope.

Notation "'⋀' ( j 'in' I ) P" := (\big[andb/true]_(j in I) P)
  (at level 41, j ident, I at level 50, P at level 41) : bool_scope.

Definition KwiseIndependent {Ω : finType} {n m : nat}
    {P : fdist (R : realType) Ω} (k : nat) (X : [n] -> {RV P -> [m]}) : Prop :=
  ∀ I : {set [n]}, (#|I| <= k)%nat ->
  ∀ x : [n] -> [m],
    let matches : {RV P -> bool} :=
      fun ω => ⋀(j in I) (X j ω == x j)
    in
    `Pr[ matches = true ]
      = \prod_(j in I) `Pr[ (X j) = (x j) ].

Definition Hash (U m : nat) :=
  {ffun [U] -> [m]}.

Definition HashFamily (U m : nat) :=
  {H : {set Hash U m} | (0 < #|H|)%nat}.

Definition h {U m : nat} (H : HashFamily U m) (x : [U])
    : {RV (fdist_uniform_supp (R : realType) (proj2_sig H)) -> [m]} :=
  fun h => h x.

Definition Uniform {U m : nat} (H : HashFamily U m) : Prop :=
  let h := h H in
  ∀ (x : [U]) (i : [m]),
    `Pr[ (h x) = i ] = 1 / (m%:R).

Definition KwiseIndependentHash {U m : nat}
    (H : HashFamily U m) (k : nat) : Prop :=
  KwiseIndependent k (h H).

Definition FullyIndependentHash {U m : nat}
    (H : HashFamily U m) : Prop :=
  KwiseIndependentHash H U.

Definition UniqueRepresentation {U m b : nat} (H : HashFamily U m)
    (encode : Hash U m -> b.-tuple bool) : Prop :=
  forall f g,
    f \in proj1_sig H ->
    g \in proj1_sig H ->
    encode f = encode g ->
    f = g.

Unset Printing Implicit Defensive.

Lemma fully_independent_bits_lower_bound
    {U m : nat} (H : HashFamily U m)
    (b : nat) (encode : Hash U m -> b.-tuple bool) :
  (0 < m)%nat ->
  Uniform H ->
  FullyIndependentHash H ->
  UniqueRepresentation H encode ->
  (m ^ U <= 2 ^ b)%nat.
Proof.
  intros m_positive uniform independent unique.
  pose distribution := fdist_uniform_supp (R : realType) (proj2_sig H).
  pose matches (f : Hash U m) : {RV distribution -> bool} :=
    fun g => ⋀(j in [set: [U]]) (g j == f j).

  (* Independence and uniformity give every output configuration positive probability. *)
  have all_inputs : (#|[set: [U]]| <= U)%nat.
    by rewrite cardsT card_ord.
  have match_probability (f : Hash U m) :
      `Pr[ (matches f) = true ] = (1 / (m%:R)) ^+ U.
    rewrite (independent [set: [U]] all_inputs (fun j => f j)).
    under eq_bigr do rewrite (uniform _ _).
    by rewrite prodr_const cardsT card_ord.

  (* Positive probability means that every hash function belongs to H. *)
  have all_functions (f : Hash U m) : f \in proj1_sig H.
    have positive : (0 < `Pr[ (matches f) = true ])%O.
      rewrite match_probability div1r.
      apply: exprn_gt0.
      by rewrite invr_gt0 ltr0n.
    have nonzero : `Pr[ (matches f) = true ] != 0.
      exact: lt0r_neq0 positive.
    have [g [matched g_positive]] := (proj1 (pfwd1_neq0 (matches f) true)) nonzero.
    have same_function : g = f.
      apply/ffunP => j.
      move: matched; rewrite inE /= /matches big_andE eqb_id.
      move/forall_inP => matched.
      have j_in : j \in [set: [U]] by rewrite inE.
      apply/eqP; exact: matched j j_in.
    rewrite -same_function.
    rewrite -(@fdist_uniform_supp_neq0 (R : realType) _ _ (proj2_sig H) g).
    exact: lt0r_neq0 g_positive.

  (* Distinct functions need distinct strings, and there are only 2^b strings. *)
  have encode_injective : injective encode.
    intros f g same_encoding.
    exact: unique f g (all_functions f) (all_functions g) same_encoding.
  have capacity := leq_card encode encode_injective.
  by rewrite card_ffun !card_ord card_tuple card_bool in capacity.
Qed.
