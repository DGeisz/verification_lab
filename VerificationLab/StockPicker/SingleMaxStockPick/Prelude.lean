import VerificationLab.StockPicker.Snapshot

def TickerSnapshot (ticker : String) := {s : Snapshot // s.ticker = ticker}

structure UnverifiedStockPick where
  ticker : String
  lower_snapshot : TickerSnapshot ticker
  upper_snapshot : TickerSnapshot ticker

def UnverifiedStockPick.value (u : UnverifiedStockPick) : Int := u.upper_snapshot.val.value - u.lower_snapshot.val.value

def StockPick := {s : UnverifiedStockPick // s.lower_snapshot.val.time ≤ s.upper_snapshot.val.time}

def StockPick.value (s : StockPick) : Int := s.val.value
