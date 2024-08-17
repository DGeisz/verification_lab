import VerificationLab.StockPicker.Snapshot
import VerificationLab.StockPicker.SingleMaxStockPick.Prelude

/- Spec -/
structure SingleMaxStockPick where
  fn : List Snapshot → StockPick
  fn_maximizes_pick (list : List Snapshot) (otherPick : StockPick) :
    (otherPick.val.upper_snapshot.val ∈ list) →
    (otherPick.val.lower_snapshot.val ∈ list) →
    (otherPick.value ≤ (fn list).value)

instance : CoeFun SingleMaxStockPick (fun _ => List Snapshot → StockPick) where
  coe s := s.fn
