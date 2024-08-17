structure Snapshot where
  ticker: String
  time: Int
  value: Int

def TickerSnapshot (ticker : String) := {s : Snapshot // s.ticker = ticker}

def tickerSnapshotLe {ticker : String} (s1 s2 : (TickerSnapshot ticker)) :=
  s1.val.time ≤ s2.val.time

instance {ticker : String} : LE (TickerSnapshot ticker) where
  le := tickerSnapshotLe

structure SnapshotsForTicker where
  ticker: String
  snapshots: List (TickerSnapshot ticker)

def listIsOrdered [LE α] (list : List α) :=
  match list with
  | a :: b :: bs => a ≤ b ∧ listIsOrdered bs
  | _ => True

def TimeOrderedSnapshotsForTicker := {p : SnapshotsForTicker // listIsOrdered p.snapshots}

structure Hello where
  sort_snapshots_by_ticker : (all_snapshots : List Snapshot) → List SnapshotsForTicker

-- def singleMaxStockPick (all_snapshots : List Snapshot) : Int :=
--   -- First sort all the stocks by ticker
--   -- Then for each ticker, find the biggest price difference
--   -- Return the biggest price difference
--   sorry
