import Mathlib
import VerificationLab.StockPicker.Snapshot
import VerificationLab.StockPicker.SingleMaxStockPick.Prelude
import VerificationLab.Tactics

def findMaxGivenElement (e : Snapshot) (list : List Snapshot) :
  {maxPick : StockPick //
    (maxPick.upper_snapshot = e ∨ maxPick.lower_snapshot = e) ∧
    ∀ otherPick : StockPick,
      (otherPick.upper_snapshot ∈ list) →
      (otherPick.lower_snapshot ∈ list) →
      (otherPick.value ≤ maxPick.value)
  } :=
  match list with
  | [] =>
    ⟨
      ⟨
        {ticker := e.ticker, upper_snapshot := ⟨e, rfl⟩, lower_snapshot := ⟨e, rfl⟩},
        by simp
      ⟩, by simp; apply Or.inl; rfl
    ⟩
  | a :: as =>
    let ⟨tailPick, tailProof⟩ := findMaxGivenElement e as
    let ⟨one, two⟩ := tailProof

    if heq: a.ticker = e.ticker then
      sorry
    else by
      return_with_proof tailPick
      · apply And.intro
        · assumption
        · intro otherPick h1 h2
          cases h1
          sorry
          sorry


def singleMaxStockPick (list : List Snapshot) : {
  maxPick : StockPick // ∀ otherPick : StockPick,
    (otherPick.upper_snapshot ∈ list) →
    (otherPick.lower_snapshot ∈ list) →
    otherPick.value ≤ maxPick.value
  } :=
  match list with
  | [] => by
    return_with_proof DEFAULT_STOCK_PICK
    · intros
      contradiction
  | a :: as =>
    let ⟨tailPick, tailProof⟩ := singleMaxStockPick as

    -- let rec findMaxGivenElement (e : Snapshot) (sublist : List Snapshot) : StockPick :=
    --   match sublist with
    --   | [] => ⟨{ticker := e.ticker, upper_snapshot := ⟨e, rfl⟩, lower_snapshot := ⟨e, rfl⟩}, by simp⟩
    --   | b :: bs =>
    --     if _: e.ticker = b.ticker then
    --       if _: e.time ≤ b.time then
    --         sorry
    --       else
    --         sorry
    --     else
    --       sorry



    sorry




structure SingleMaxStockPickSpec (list : List Snapshot) (maxPick : StockPick) : Prop where
  fn_maximizes_pick (otherPick : StockPick) :
    (otherPick.upper_snapshot ∈ list) →
    (otherPick.lower_snapshot ∈ list) →
    (otherPick.value ≤ maxPick.value)

-- def singleMaxStockPick (list : List Snapshot) : {maxPick : StockPick // SingleMaxStockPickSpec list maxPick} := sorry
  -- Organize list by stock ticker
  -- Sort each stock ticker list
  -- Find the max of each list
  -- Return the max of everything

-- Unverified

def List.__addToList (item : Snapshot) (exi : List TickerSnapshotList) : List TickerSnapshotList :=
  match exi with
  | [] => [{ticker := item.ticker, snapshots := [⟨item, rfl⟩]}]
  | e :: es =>
    if h: item.ticker = e.ticker then
      let new_list := {e with snapshots := ⟨item, h⟩ :: e.snapshots}

      new_list :: es
    else
      e :: addToList item es

def __organize (list : List Snapshot) : List TickerSnapshotList :=
  match list with
  | [] => []
  | a :: as =>
    let or := __organize as

    or.__addToList a

def splitListAtIndex (list : List α) (i : Nat) : List α × List α :=
  match list, i with
  | [], _ => ([], [])
  | l, 0 => ([], l)
  | a :: as, n + 1 =>
    let (l1, l2) := splitListAtIndex as n
    (a :: l1, l2)

def mergeLists : (l1 l2 : List (TickerSnapshot ticker)) → List (TickerSnapshot ticker)
  | [], l2 => l2
  | l1, [] => l1
  | a :: as, b :: bs =>
    if a.val.time ≤ b.val.time then
      a :: mergeLists as (b :: bs)
    else
      b :: mergeLists (a :: as) bs

#print mergeLists.eq_1

-- def mergeSort (list : List (TickerSnapshot ticker)) →






def __singleMaxStockPick (list : List Snapshot) : StockPick := sorry
  -- Organize list by stock ticker
  -- Sort each stock ticker list
  -- Find the max of each list
  -- Return the max of everything

/- Spec -/
-- structure SingleMaxStockPick where
--   fn : List Snapshot → StockPick
--   fn_maximizes_pick (list : List Snapshot) (otherPick : StockPick) :
--     (otherPick.val.upper_snapshot.val ∈ list) →
--     (otherPick.val.lower_snapshot.val ∈ list) →
--     (otherPick.value ≤ (fn list).value)

-- instance : CoeFun SingleMaxStockPick (fun _ => List Snapshot → StockPick) where
--   coe s := s.fn
