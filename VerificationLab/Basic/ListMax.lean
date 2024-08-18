import Mathlib

syntax "return_with_proof" term : tactic

macro_rules
  | `(tactic| return_with_proof $a:term) => `(tactic| apply Subtype.mk (val := $a))

def maxListVerified (l : List Nat) : {max : Nat // ∀ n : Nat, n ∈ l → n ≤ max} :=
  match l with
  | [] => by
    return_with_proof 0
    · intros
      contradiction
  | a :: as =>
    let ⟨maxTail, maxTailProp⟩ := maxListVerified as

    if _ : a > maxTail then by
      return_with_proof a
      · intro n h
        cases h
        case head => linarith
        case tail n_in_as =>
          apply Nat.le_trans (m := maxTail)
          · exact maxTailProp n n_in_as
          · linarith
    else by
      return_with_proof maxTail
      · intro n h
        cases h
        case head => linarith
        case tail n_in_as => exact maxTailProp n n_in_as

-- This just creates the function and then proves it elsewhere
def maxList (l : List Nat) : Nat :=
  match l with
  | [] => 0
  | h :: t =>
    let maxTail := maxList t
    if h > maxTail then h else maxTail


theorem maxListMaxV0 : ∀ l : List Nat, ∀ n : Nat, n ∈ l → n ≤ maxList l :=
  fun l n =>
    match l with
    | [] => fun h => nomatch h
    | a :: as =>
      fun  h1 =>

      match h1 with
      | List.Mem.head ass =>
        let maxTail := maxList ass

        if h2 : n > maxTail then
          let b : maxList (n :: ass) = n := if_pos h2

          let c : n = maxList (n :: ass) := Eq.symm b
          let d : n ≤ n := Nat.le.refl

          c ▸ d
        else
          let b : maxList (n :: ass) = maxTail := if_neg h2
          let c : n ≤ maxTail := Nat.le_of_not_gt h2

          b ▸ c
      | List.Mem.tail aa n_in_as =>
        let maxTail := maxList as

        let cc : n ≤ maxList as := maxListMaxV0 as n n_in_as

        if h3 : maxTail < aa then
          let c : maxList (aa :: as) = aa := if_pos h3
          let d : aa = maxList (aa :: as) := Eq.symm c

          let e : maxTail < maxList (aa :: as) := d ▸ h3
          let f : maxTail ≤ maxList (aa :: as) := Nat.le_of_lt e

          Nat.le_trans cc f
        else
          let c : maxList (aa :: as) = maxTail := if_neg h3
          let d : maxTail = maxList (aa :: as) := Eq.symm c

          d ▸ cc

example (a b : Nat) : a < b → a ≤ b := by apply Nat.le_of_lt

theorem maxListMaxV1: ∀ l : List Nat, ∀ n : Nat, n ∈ l → n ≤ maxList l := by
  intro l n hnl
  match l with
  | [] => contradiction
  | a :: as =>
    simp [maxList]
    split
    · case isTrue h =>
      cases hnl with
      | head => simp
      | tail _ hh =>
        apply Nat.le_trans (m := maxList as)
        · exact maxListMaxV1 as n hh
        · apply Nat.le_of_lt h
    · case isFalse h =>
      cases hnl with
      | head =>
        apply Nat.le_of_not_gt
        assumption
      | tail _ hh =>
        exact maxListMaxV1 as n hh
