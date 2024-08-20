import VerificationLab.StockPicker.Snapshot
import VerificationLab.Tactics

def DEFAULT_SNAP : Snapshot := {ticker := "ex", time := 0, value := 0}

def TickerSnapshot (ticker : String) := {s : Snapshot // s.ticker = ticker}
def DEFAULT_TICKER_SNAP : TickerSnapshot "ex" := ⟨DEFAULT_SNAP, rfl⟩


structure UnverifiedStockPick where
  ticker : String
  lower_snapshot : TickerSnapshot ticker
  upper_snapshot : TickerSnapshot ticker


def UnverifiedStockPick.value (u : UnverifiedStockPick) : Int := u.upper_snapshot.val.value - u.lower_snapshot.val.value

def StockPick := {s : UnverifiedStockPick // s.lower_snapshot.val.time ≤ s.upper_snapshot.val.time}

def StockPick.value (s : StockPick) : Int := s.val.value

def StockPick.upper_snapshot (s : StockPick) : Snapshot := s.val.upper_snapshot.val
def StockPick.lower_snapshot (s : StockPick) : Snapshot := s.val.lower_snapshot.val

def DEFAULT_STOCK_PICK : StockPick := ⟨{ticker := "ex", lower_snapshot := DEFAULT_TICKER_SNAP, upper_snapshot := DEFAULT_TICKER_SNAP}, by simp⟩

-- Helper Methods
structure TickerSnapshotList where
  ticker : String
  snapshots : List (TickerSnapshot ticker)

def addToList (newSnapshot : Snapshot) (list : List TickerSnapshotList) : {newList : List TickerSnapshotList // True} := sorry

structure OrganizeStocksByTickerSpec : Prop where

def organizeStocksByTicker (snapshotList : List Snapshot) : {organizedTickerList : List TickerSnapshotList // OrganizeStocksByTickerSpec } :=
  match snapshotList with
  | [] => by
    return_with_proof []
    · exact {}
  | a :: as =>
    let ⟨organizedSubList, subListSpec⟩ := organizeStocksByTicker as
    sorry
